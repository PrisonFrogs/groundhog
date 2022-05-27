Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get '/auth/shake', to: 'authentication#shake'
    get '/auth/login', to: 'authentication#login'
  end
end
