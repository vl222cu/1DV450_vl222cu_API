class PlacesController < ApplicationController
  respond_to :json
  before_action :api_key
end
