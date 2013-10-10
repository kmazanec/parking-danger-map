class MapsController < ApplicationController

  def index
    @ticket = Ticket.new
  end

end