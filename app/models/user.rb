class User < ApplicationRecord::Base
  has_secure_password
  enum age: {
    secret: 0,
    male: 1,
    female: 2
  }
end
