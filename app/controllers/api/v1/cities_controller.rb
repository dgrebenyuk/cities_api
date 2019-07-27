# frozen_string_literal: true

class Api::V1::CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    cities = params[:featured] ? City.featured : City.list
    render jsonapi: cities
  end

  def create
    city = City.new(city_params)

    if city.save
      render jsonapi: city
    else
      render jsonapi_errors: city.errors
    end

  rescue ActionController::ParameterMissing => e
    render json: { errors: [I18n.t('errors.missing_param', name: e.message[/:\s\K.*/])] }, status: :bad_request
  end

  private

  def city_params
    params.require(:city).require([:name, :description, :population])
    params.require(:city).permit(:name, :description, :population)
  end
end
