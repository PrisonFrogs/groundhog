class Post < ApplicationRecord
  include SoftDeletable
  include PostsListConcern

  belongs_to :user
  belongs_to :post, optional: true
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :content, :user, presence: true

  delegate :nickname, to: :author, prefix: :author

  def author
    user
  end

  def liked_by?(user)
    liked_users.include?(user)
  end

  def liked_by(user)
    like = likes.find_or_initialize_by(user:)

    like.new_record? ? like.save : like.destroy
  end
end
