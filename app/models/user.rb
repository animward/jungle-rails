class User < ApplicationRecord
  has_secure_password

  before_save { self.email = email.strip.downcase }

  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, length: { in: 4..16 }
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end