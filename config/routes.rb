Rails.application.routes.draw do
  post '/ping', to: 'ping#create'
end
