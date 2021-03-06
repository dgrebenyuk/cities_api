# frozen_string_literal: true

class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = User.find_by(email: user_params[:email])
    if user&.valid_password? user_params[:password]
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: [I18n.t('errors.invalid_credentials')] }, status: :unauthorized
    end
  rescue ActionController::ParameterMissing => e
    render(json: { errors: [I18n.t('errors.missing_param', name: e.message[/:\s\K.*/])] }, status: :bad_request)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
