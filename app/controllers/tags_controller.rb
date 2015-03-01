class TagsController < ApplicationController
  respond_to :json
  #before_action :api_key
  #before_action :api_authenticate, only: [:create]
  before_action :offset_params, only: [:index]
  
  # GET all tags
  def index
    tags = Tag.limit(@limit).offset(@offset)
    respond_with tags, status: :ok, location: tags_path
  end
  
  # GET a specific tag
  def show
    @tag = Tag.find_by_id(params[:id])
    if @tag.present?
      respond_with @tag, status: :ok, location: tags_path(@tag)
    else
      render json: {error: 'Could not find the resource. Check if you are using the right tag_id.'}, status: :not_found
    end
  end
  
  # POST a tag
  def create
    tag = Tag.new(tag_params)
    if tag.save
      respond_with tag, status: :created
    else
      render json: {error: 'Could not create the resource. Check if you are using the required parameters.'}, status: :unprocessable_entity
    end
  end

  private

  def tag_params
    params.required(:tag).permit(:name)
  end
  
end
