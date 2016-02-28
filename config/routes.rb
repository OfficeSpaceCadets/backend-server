Rails.application.routes.draw do
  get 'home/index'

  namespace :api do
    post '/ping', to: 'ping#create'
  end

  root to: 'home#index'
end
