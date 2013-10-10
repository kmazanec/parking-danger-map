class User < ActiveRecord::Base
	has_many :tickets

  has_secure_password

  validates :email, presence:   true
  validates :email, uniqueness: true
  validates :email, format:      /.*@.*\..*/
  validates :password_digest, :presence => true
end
