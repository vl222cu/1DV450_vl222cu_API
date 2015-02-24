class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
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
  
  # check if api_key is included in header
  def api_key
    api_key = request.headers['X-ApiKey']
      #Check if api_key exists
    if api_key.nil?
      render json: {error: 'No Key'}, status: :bad_request
      return false
    end
    return true
  end
  
end
