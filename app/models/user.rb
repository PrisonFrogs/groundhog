class User < ApplicationRecord
  has_secure_password
  validates :email, :nickname, :password_digest, presence: true
  validates :password_digest, length: { minimum: 8 }
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  enum gender: {
    secret: 0,
    male: 1,
    female: 2
  }
end
