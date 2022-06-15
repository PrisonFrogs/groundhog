class Post < ApplicationRecord
  include SoftDeletable
  include PostsListConcern

  belongs_to :user
  belongs_to :post, optional: true
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, class_name: 'Post', dependent: :destroy

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

    new_like = like.new_record?

    new_like ? like.save : like.destroy

    new_like
  end

  def likes_count
    likes.size
  end
end
