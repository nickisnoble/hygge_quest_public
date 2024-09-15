class LocationsController < ApplicationController
  def index
    @locations = Location.all
    render json: @locations
  end
end
