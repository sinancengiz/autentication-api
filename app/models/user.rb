class User < ApplicationRecord
    # encrypt password
  has_secure_password

  # Validations
  validates_presence_of :email, :user_name, :password_digest
  validates_uniqueness_of :email

  before_save :downcase_fields

  def send_password_reset
    self.password_reset_token = generate_base64_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def password_token_valid?
    (self.password_reset_sent_at + 24.hour) > Time.zone.now
  end

  def reset_password(password)
    self.password_reset_token = nil
    self.password = password
    save!
  end

  private

  def generate_base64_token
    test = SecureRandom.urlsafe_base64
  end

  def downcase_fields
    self.email.downcase!
  end
end
