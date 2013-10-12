class MapsController < ApplicationController
  skip_before_filter :require_login
  def index
    @ticket = Ticket.new
  end

  def map_data
    # remember to add a route for this get request
    p "these are the params ++++++++++++++++++"
    p params
    # @locations = Location.where("latitude < #{params[ne:[0]]} AND latitude > #{params[sw:[0]]} AND longitude > #{params[ne:[1]]} AND longitude < #{params[sw:[1]]}")

    # dataPoints = @locations.map do |location|
    #   [location.latitude, location.longitude]
    # end
    # render :json => dataPoints.to_json
  end

  def map_data_tile
    p "These are the post params ++++++++++++++++++++"
    p params
    Location.create(latitude: params[:latitu])
  end

end
