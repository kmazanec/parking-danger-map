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
     tickets_in_frame = @locations.map do |location|
      [location.latitude, location.longitude]
    end
    render :json => tickets_in_frame.to_json
  end

  def map_data_tickets
    @locations = Location.where("latitude < #{params[:maxLat]} AND latitude > #{params[:minLat]} AND longitude > #{params[:minLong]} AND longitude < #{params[:maxLong]}").limit(100)
    tickets_in_frame = @locations.map do |location|
      @current_ticket = Ticket.find_by(location_id: location.id)
      current_ticket_html = "<h4>#{@current_ticket.issued_at.strftime('%a. %b %-d, %Y')}</h4>
                              <b>Violation:</b> #{@current_ticket.violation}<br>
                              <b>Fine:</b> #{@current_ticket.fine}<br>
                              <b>Status:</b> #{@current_ticket.status}<br>
                              <b>Officer:</b> #{@current_ticket.officer}"
      [location.latitude, location.longitude, @current_ticket.violation, current_ticket_html]
    end

    render :json => tickets_in_frame.to_json
  end

end
