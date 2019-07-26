Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_for :users, only: :registrations
      post :auth, to: 'authentication#create'
      resources :cities
      resources :favourites, only: [:index, :create]
      delete 'favourite/:city_id', to: 'favourites#destroy'
    end
  end
end
