class CreatorsController < ApplicationController
  respond_to :json
  #before_action :api_key
  before_action :api_authenticate, only: [:index]
  before_action :offset_params, only: [:index]
  
  # Get all creators
  def index
    creators = Creator.limit(@limit).offset(@offset).includes(:places)
    respond_with creators, status: :ok, location: creators_path
  end
  
  # Get a specific creator
  def show
    @creator = Creator.find_by_id(params[:id])
    respond_with @creator, status: :ok, location: creators_path(@creator)
  end
  
  # Post a creator
  def create
    creator = Creator.new(creator_params)
    if creator.save
      respond_with creator, status: :created
    else
      respond_with creator.errors, status: :unprocessable_entity
    end
  end

  private

  def creator_params
    json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
    json_params.require(:creator).permit(:username, :email, :password)
  end

end
