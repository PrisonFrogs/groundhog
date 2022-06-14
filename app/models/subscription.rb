class Subscription < ApplicationRecord
  belongs_to :user
  has_one :subscriber, class_name: 'User', primary_key: :subscriber_id, foreign_key: :id

  validates :subscriber_id, presence: true
  validates :subscriber_id, uniqueness: { scope: :user_id }
end
