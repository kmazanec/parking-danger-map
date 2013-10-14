class Ticket < ActiveRecord::Base
	belongs_to :user
	belongs_to :location

  validates :user_id, presence: true
  validates :location_id, presence: true
  validates :issued_at, presence: true
end
