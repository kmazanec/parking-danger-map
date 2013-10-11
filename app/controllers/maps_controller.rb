class MapsController < ApplicationController

  def index
    @ticket = Ticket.new
  end

  def map_data
    # remember to add a route for this get request
    @locations = Location.all
     
    dataPoints = @locations.map do |location|
      [location.latitude, location.longitude]
    end
    render :json => dataPoints.to_json
  end

end
