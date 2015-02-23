class Creator < ActiveRecord::Base
  has_many :places
  before_save { self.email = email.downcase }
  
  validates :username, presence: true, length: {maximum: 50}
  validates :password, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true, email_format: { message: "doesn't look like an email address" }
  has_secure_password
end
