class User < ApplicationRecord
    # encrypt password
  has_secure_password

  # Validations
  validates_presence_of :user_name, :email, :password_digest
  validates_uniqueness_of :user_name, :email
end
