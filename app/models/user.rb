class User < ActiveRecord::Base
	has_many :tickets
end
