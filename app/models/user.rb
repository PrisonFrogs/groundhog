class User < ApplicationRecord
  has_secure_password
  validates :email, :nickname, :password, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

  has_many :liked_posts, through: :likes
  has_many :refresh_tokens, dependent: :destroy

  # fans
  has_many :fan_subscriptions, class_name: 'Subscription', dependent: :destroy
  has_many :subscribers, through: :fan_subscriptions, class_name: 'User', source: :subscriber, dependent: nil

  # subscriptions
  has_many :subscriptions, dependent: :destroy, foreign_key: :subscriber_id
  has_many :subscribed_to, through: :subscriptions, source: :user, dependent: nil

  enum gender: {
    secret: 0,
    male: 1,
    female: 2
  }

  def to_token
    Jwt::IssueService.call(self)
  end

  def to_payload
    {
      id:,
      email:,
      gender:,
      nickname:
    }
  end

  def authenticated?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def subscribe(user)
    subscriptions.create(user:)
  end

  def unsubscribe(user)
    subscriptions.find_by(user:).destroy
  end

  def subscribe!(user)
    subscriptions.create!(user:)
  end
end
