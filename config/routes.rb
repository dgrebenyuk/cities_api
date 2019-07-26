Rails.application.routes.draw do
  # Move devise from namespace to prevent adding prefix to helpers
  scope '/api/v1', defaults: {format: :json} do
    devise_for :users, only: :registrations
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post :auth, to: 'authentication#create'
      resources :cities
      resources :favourites, only: [:index, :create]
      delete 'favourite/:city_id', to: 'favourites#destroy'
    end
  end
end
