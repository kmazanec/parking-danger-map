class VerifiedUser < User
	has_secure_password
	validates :email, uniqueness: true, presence: true
end