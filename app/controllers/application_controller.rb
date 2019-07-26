class ApplicationController < ActionController::API
  respond_to :html, :json
  before_action :authenticate_user!
end
