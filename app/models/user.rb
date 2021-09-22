class User < ApplicationRecord
    # encrypt password
  has_secure_password

  # Model associations
  has_and_belongs_to_many :games
  # Validations
  validates_presence_of :user_name, :email, :password_digest
end
