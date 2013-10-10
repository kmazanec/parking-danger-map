class MapsController < ApplicationController

  def index
    @ticket = Ticket.new
  end

  def map_data
    @locations = Location.all
    content_type :json
    {locations:  
    @locations.map do |location|
      {latitude: location.latitude, longitude: location.longitude}
    end
    }.to_json
  end

end
