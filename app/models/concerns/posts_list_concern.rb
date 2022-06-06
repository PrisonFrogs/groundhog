module PostsListConcern
  extend ActiveSupport::Concern

  included do
    scope :list_on_homepage, -> { where('created_at > ?', 3.days.ago).order(updated_at: :desc) }

    def as_json(options = {})
      options = options.merge(methods: :author_nickname)
      super(options)
    end
  end
end
