class Location < ActiveRecord::Base
  geocoded_by :user_submission
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.address = geo.address.split(",")[0]
      obj.city    = geo.city
      obj.state   = geo.state_code
      obj.zip     = geo.postal_code
    end
  end
  after_validation :geocode
  after_validation :reverse_geocode

end
