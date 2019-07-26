Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_for :users, only: :registrations
      post :auth, to: 'authentication#create'
      resources :cities
    end
  end
end
