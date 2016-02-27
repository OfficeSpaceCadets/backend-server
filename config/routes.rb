Rails.application.routes.draw do
  get 'home/index'

  post '/ping', to: 'ping#create'

  root to: 'home#index'
end
