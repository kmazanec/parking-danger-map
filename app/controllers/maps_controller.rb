class MapsController < ApplicationController
  skip_before_filter :require_login
  def index
    @ticket = Ticket.new
  end

  def map_data
    # remember to add a route for this get request
    @locations = Location.limit(800)

    dataPoints = @locations.map do |location|
      [location.latitude, location.longitude]
    end
    render :json => dataPoints.to_json
  end

end
