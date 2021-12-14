class User < ApplicationRecord
  validates :username, presence: true
  validates :password_digest, presence: true
  # validates :password, presence: true, length: { minimum: 6, maximum: 25 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}+\z/i }
  has_secure_password
end
