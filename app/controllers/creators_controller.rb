class CreatorsController < ApplicationController
  respond_to :json
  before_action :api_key
  before_action :offset_params, only: [:index]
  
  def index
    creators = Creator.limit(@limit).offset(@offset).includes(:places)
    render json: creators, status: :ok
  end
  
  def show
    @creator = Creator.find_by_id(params[:id])
    respond_with @creator, location: creators_path(@creator)
  rescue ActiveRecord::RecordNotFound

  def create
    creator = Creator.new(creator_params)
    if creator.save
      render json: creator, status: :created
    else
      render json: creator.errors, status: :unprocessable_entity
    end
  end

  private

  def creator_params
    params.require(:creator).permit(:username, :email, :password)
  end

end
