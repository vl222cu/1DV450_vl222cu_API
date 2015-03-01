class PlacesController < ApplicationController
  respond_to :json
  #before_action :api_key
  before_action :offset_params, only: [:index, :nearby]
  
  # GET all places
  def index
    places = Place.limit(@limit).offset(@offset)
    respond_with places, status: :ok, location: places_path
  end
  
  # GET a specific place
  def show
    @place = Place.find_by_id(params[:id])
    if @place.present?
      respond_with @place, status: :ok, location: places_path(@place)
    else
      render json: {error: 'Could not find the resource. Check if you are using the right place_id.'}, status: :not_found
    end
  end
  
  # POST a place
  def create
    place = Place.new(place_params)
    if place.save
      respond_with place, status: :created
    else
      render json: {error: 'Could not create the resource. Check if you are using the required parameters.'}, status: :unprocessable_entity
    end
  end
  
  # Geocoder is used to look up places near a specific spot
  def nearby
    if params[:latitude].present? && params[:longitude].present?
      places = Place.near([params[:latitude].to_f, params[:longitude].to_f], 50, :order => :distance, units: :km).limit(@limit).offset(@offset)
      if places.present?
        respond_with places, status: :ok, location: places_path
      else
        render json: {error: 'Could not find any resources nearby stated location.'}, status: :not_found
      end
    else
      render json: {error: 'Could not find any resources. Check if you are using the required parameters.'}, status: :bad_request
    end
  end
    
  private
    
    def place_params
      params.require(:place).permit(:creator_id, :name, :text, :longitude, :latitude, tags_attributes: [:name] )
    end
    
end
