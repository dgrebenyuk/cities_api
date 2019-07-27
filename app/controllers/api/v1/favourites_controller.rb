class Api::V1::FavouritesController < ApplicationController
  def index
    render jsonapi: current_user.cities
  end

  def create
    city = City.find_by(id: favourite_params[:city_id])
    render(json: { errors: [I18n.t('errors.invalid_city')] }, status: :unprocessable_entity) and return unless city
    current_user.cities << city
    render jsonapi: city
  rescue ActionController::ParameterMissing => e
    render json: { errors: [I18n.t('errors.missing_param', name: e.message[/:\s\K.*/])] }, status: :bad_request
  end

  def destroy
    city = City.find_by(id: params[:city_id])
    render(json: { errors: [I18n.t('errors.invalid_city')] }, status: :unprocessable_entity) and return unless city
    if current_user.cities.exists?(city.id)
      current_user.cities.destroy(city)
      render jsonapi: city
    else
      render(json: { errors: [I18n.t('errors.city_not_favourite')] }, status: :unprocessable_entity)
    end
  end

  private

  def favourite_params
    params.require(:favourite).permit(:city_id)
  end
end
