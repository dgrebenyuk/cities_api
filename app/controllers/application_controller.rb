class ApplicationController < ActionController::API
  respond_to :html, :json
  before_action :authenticate_api_v1_user!
end
