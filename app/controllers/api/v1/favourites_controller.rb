class Api::V1::FavouritesController < ApplicationController
  def index
    render jsonapi: current_user.cities
  end

  def create
    city = City.find_by(id: favourite_params[:city_id])
    render(json: { errors: "City not found" }, status: :unprocessable_entity) and return unless city
    current_user.cities << city
    render jsonapi: city

  rescue ActionController::ParameterMissing => e
    render json: { errors: "Missing #{e.message[/:\s\K.*/]} parameter" }, status: :unprocessable_entity
  end

  def destroy
    city = City.find_by(id: params[:city_id])
    render(json: { errors: "City not found" }, status: :unprocessable_entity) and return unless city
    current_user.cities.destroy(city)
    render jsonapi: city
  end

  private

  def favourite_params
    params.require(:favourite).permit(:city_id)
  end
end
