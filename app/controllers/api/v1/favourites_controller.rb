class Api::V1::FavouritesController < ApplicationController
  def index
    render jsonapi: current_user.cities
  end

  def create
    city = City.find_by(id: favourite_params[:city_id])
    render(jsonapi_errors: 'City not found') and return unless city
    current_user.cities << city
    render jsonapi: city
  end

  def destroy
    city = City.find_by(id: params[:city_id])
    render(jsonapi_errors: 'City not found') and return unless city
    current_user.cities.destroy(city)
    render jsonapi: city
  end

  private

  def favourite_params
    params.require(:favourite).permit(:city_id)
  end
end
