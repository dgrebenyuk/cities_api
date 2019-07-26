class Api::V1::CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    render jsonapi: City.all
  end
end
