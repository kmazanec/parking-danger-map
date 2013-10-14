class MapsController < ApplicationController
  skip_before_filter :require_login
  def index
    @ticket = Ticket.new
  end

  def map_data
    # remember to add a route for this get request
    p "these are the params ++++++++++++++++++"
    p params
    @locations = Location.limit(500)

    dataPoints = @locations.map do |location|
      [location.latitude, location.longitude]
    end
    render :json => dataPoints.to_json
  end

  def map_data_tile
    @locations = Location.where("latitude < #{params[:maxLat]} AND latitude > #{params[:minLat]} AND longitude > #{params[:minLong]} AND longitude < #{params[:maxLong]}").sample(1200)
    p "these are the locations in frame"
    p @locations
     tickets_in_frame = @locations.map do |location|
      [location.latitude, location.longitude]
    end
    render :json => tickets_in_frame.to_json

  end

end
