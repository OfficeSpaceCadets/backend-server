Rails.application.routes.draw do
  get 'home/index'
  resource 'latest_session', only: :show

  namespace :api do
    post '/ping', to: 'ping#create'
  end

  root to: 'home#index'
end
