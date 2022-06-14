class Subscription < ApplicationRecord
  belongs_to :user, dependent: nil
  has_one :subscriber, class_name: 'User', primary_key: :subscriber_id, foreign_key: :id, dependent: nil,
                       inverse_of: :fan_subscriptions

  validates :subscriber_id, presence: true
  validates :subscriber_id, uniqueness: { scope: :user_id }
end
