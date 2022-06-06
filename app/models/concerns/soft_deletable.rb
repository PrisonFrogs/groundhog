module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(is_deleted: false) }
    scope :only_deleted, -> { unscope(where: :is_deleted).where(is_deleted: true) }
  end

  def delete
    update(is_deleted: true) if has_attribute? :is_deleted
  end

  def destroy
    callbacks_result = transaction do
      run_callbacks(:destroy) do
        delete
      end
    end
    callbacks_result ? self : false
  end

  def self.included(klazz)
    klazz.extend Callbacks
  end

  module Callbacks
    def self.extended(klazz)
      klazz.define_callbacks :restore
      klazz.define_singleton_method('before_restore') do |*args, &block|
        set_callback(:restore, :before, *args, &block)
      end
      klazz.define_singleton_method('around_restore') do |*args, &block|
        set_callback(:restore, :around, *args, &block)
      end
      klazz.define_singleton_method('after_restore') do |*args, &block|
        set_callback(:restore, :after, *args, &block)
      end
    end
  end

  def restore!(opts = {})
    self.class.transaction do
      run_callbacks(:restore) do
        update(is_deleted: false)
        restore_associated_records if opts[:recursive]
      end
    end
    self
  end

  alias restore restore!

  def restore_associated_records
    destroyed_associations = self.class.reflect_on_all_associations.select do |association|
      association.options[:dependent] == :destroy
    end
    destroyed_associations.each do |association|
      association_data = send(association.name)
      if !association_data.nil? && association_data.is_deleted?
        if association.collection?
          association_data.only_deleted.each { |record| record.restore(recursive: true) }
        else
          association_data.restore(recursive: true)
        end
      end
      next unless association_data.nil? && association.macro.to_s == 'has_one'

      association_class_name = association.options[:class_name].presence || association.name.to_s.camelize
      association_foreign_key = association.options[:foreign_key].presence || "#{self.class.name.to_s.underscore}_id"
      Object.const_get(association_class_name).only_deleted.where(association_foreign_key, id).first.try(
        :restore, recursive: true
      )
    end
    clear_association_cache if destroyed_associations.present?
  end
end
