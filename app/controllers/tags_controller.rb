class TagsController < ApplicationController
  respond_to :json
  before_action :api_key
  before_action :api_authenticate, only: [:create, :destroy]
  before_action :offset_params, only: [:index]
  before_action :fetch_tag, only: [:show, :destroy]
  
  # GET all tags
  def index
    tags = Tag.limit(@limit).offset(@offset)
    if tags.present?
      respond_with tags, status: :ok, location: tags_path
    else
      render json: {error: 'Could not find any resources at all.'}, status: :not_found
    end
  end
  
  # GET a specific tag
  def show
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

  # DELETE a tag
  def destroy
    if @tag.destroy
      render json: {success: 'The resource is successfully deleted.'}, status: :ok
    else
      render json: {error: 'Could not delete the resource. Check if you are using the required parameters.'}, status: :unprocessable_entity
    end
  end
  
  private

  def fetch_tag
    @tag = Tag.find_by_id(params[:id])
  end
  
  def tag_params
    params.required(:tag).permit(:name)
  end
  
end
