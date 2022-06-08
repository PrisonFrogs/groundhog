class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, :post_id, presence: true
  validates :user_id, uniqueness: { scope: :post_id, message: 'can only like a post once' }, on: :create
end
