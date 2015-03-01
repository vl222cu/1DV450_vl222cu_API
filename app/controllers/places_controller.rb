class PlacesController < ApplicationController
  respond_to :json
  #before_action :api_key
  #before_action :api_authenticate, only: [:create, :update, :destroy]
  before_action :offset_params, only: [:index, :nearby]
  before_action :fetch_place, only: [:show, :update, :destroy]
  
  # GET all places
  def index
    places = Place.limit(@limit).offset(@offset).latest
    if places.present?
      respond_with places, status: :ok, location: places_path
    else
      render json: {error: 'Could not find any resources at all.'}, status: :not_found
    end
  end
  
  # GET a specific place
  def show
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
  
  # PUT a place
  def update
    if @place.update_attributes(place_params)
      render json: {success: 'The resource is successfully updated'}, status: :ok
    else
      render json: {error: 'Could not update the resource. Check if you are using the required parameters.'}, status: :unprocessable_entity
    end
  end
  
  # DELETE a place
  def destroy
    if @place.destroy
      render json: {success: 'The resource is successfully deleted.'}, status: :ok
    else
      render json: {error: 'Could not delete the resource. Check if you are using the required parameters.'}, status: :unprocessable_entity
    end
  end
  
  # Geocoder is used to look up places near a specific spot
  def nearby
    if params[:latitude].present? && params[:longitude].present?
      places = Place.near([params[:latitude].to_f, params[:longitude].to_f], 50, units: :km).limit(@limit).offset(@offset)
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
    
  def fetch_place
    @place = Place.find_by_id(params[:id])
  end
  
  def place_params
    params.require(:place).permit(:creator_id, :name, :text, :longitude, :latitude, tags_attributes: [:name] )
  end  
end
