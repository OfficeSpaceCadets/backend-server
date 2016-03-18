Rails.application.routes.draw do
  get 'home/index'
  resource 'latest_session', only: [:show]

  namespace :api do
    post '/ping', to: 'ping#create'
    get '/latest_session', to: 'latest_session#show'
    get '/todays_sessions', to: 'todays_sessions#index'
  end

  root to: 'home#index'
end
