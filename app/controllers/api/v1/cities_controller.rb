class Api::V1::CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    render jsonapi: City.all
  end

  def create
    city = City.new(city_params)

    if city.save
      render jsonapi: city
    else
      render jsonapi_errors: city.errors
    end
  end

  private

  def city_params
    params.require(:city).require([:name, :description, :population])
    params.require(:city).permit(:name, :description, :population)
  end
end
