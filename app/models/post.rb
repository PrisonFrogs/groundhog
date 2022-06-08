class Post < ApplicationRecord
  include SoftDeletable
  include PostsListConcern

  belongs_to :user
  belongs_to :post, optional: true

  validates :content, :user, presence: true

  delegate :nickname, to: :author, prefix: :author

  def author
    user
  end
end
