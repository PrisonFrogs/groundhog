class User < ApplicationRecord::Base
  has_secure_password
  validates :email, :nickname, :password_digest, :bio, presence: true
  enum age: {
    secret: 0,
    male: 1,
    female: 2
  }
end
