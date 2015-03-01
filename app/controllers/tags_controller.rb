class TagsController < ApplicationController
  respond_to :json
  before_action :api_key
  before_action :api_authenticate, only: [:create]
  before_action :offset_params, only: [:index]
  
  # GET all tags
  def index
    tags = Tag.limit(@limit).offset(@offset)
    respond_with tags, status: :ok, location: tags_path
  end
  
end
