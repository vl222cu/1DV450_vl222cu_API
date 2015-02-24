class CreatorsController < ApplicationController
  respond_to :json
  before_action :api_key
  
  def index
    creators = Creator.limit(@limit).offset(@offset)
    render json: creators, status: :ok
  end

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
