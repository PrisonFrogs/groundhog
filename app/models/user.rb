class User < ApplicationRecord
  has_secure_password
  validates :email, :nickname, :password, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

  has_many :refresh_tokens

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
end
