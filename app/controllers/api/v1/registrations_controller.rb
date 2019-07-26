# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  def resource_name
    :user
   end
end
