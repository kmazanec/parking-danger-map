class LocationsController < ApplicationController

def index
  if params[:search].present?
    @locations = Location.near(params[:search], 50, :order => :distance)
  else
    @locations = Location.all
  end
end

def show
  @location = Location.find(params[:id])

end



end
