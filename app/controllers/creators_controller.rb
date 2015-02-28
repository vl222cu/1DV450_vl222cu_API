class CreatorsController < ApplicationController
  respond_to :json
  #before_action :api_key
  before_action :api_authenticate, only: [:index]
  before_action :offset_params, only: [:index]
  
  # GET all creators
  def index
    creators = Creator.limit(@limit).offset(@offset).includes(:places)
    respond_with creators, status: :ok, location: creators_path
  end
  
  # GET a specific creator
  def show
    @creator = Creator.find_by_id(params[:id])
    if @creator.present?
      respond_with @creator, status: :ok, location: creators_path(@creator)
    else
      render json: {error: 'Could not find the resource. Check if you are using the right creator_id.'}, status: :not_found
    end
  end
  
  # POST a creator
  def create
    creator = Creator.new(creator_params)
    if creator.save
      respond_with creator, status: :created
    else
      render json: {error: 'Could not create the resource. Check if you are using the required parameters.'}, status: :unprocessable_entity
    end
  end

  private

  def creator_params
    params.require(:creator).permit(:username, :email, :password)
  end
end
