class PlacesController < ApplicationController
  respond_to :json
  before_action :api_key
  
  # Geocoder is used to look up places near a specific spot
  def nearby
    if params[:latitude].present? && params[:longitude].present?
      @places = Place.near([params[:latitude].to_f, params[:longitude].to_f], 50, :order => :distance).limit(@limit).offset(@offset)
      respond_with @places, status :ok location: places_path(@places)
  end
end
