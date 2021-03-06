class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception  
  
  include SessionsHelper
  
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  
  # default parameters
  OFFSET = 0
  LIMIT = 20
  
  # check if developer wants offset/limit
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
    @offset ||= OFFSET
    @limit  ||= LIMIT
  end
 
  # Check if api_key is included in header
  def api_key
    api_key = request.headers['apiKey']
    if api_key.present?
      return true
    else
      render json: {error: 'A valid api-key is missing in the header in order to access requested data.'}, status: :unauthorized
      return false
    end
  end
  
  # Error handler for bad format
  def raise_bad_format
    render json: { error: "The API does not support the requested format" }, status: :bad_request
  end
end
