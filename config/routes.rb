Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get '/auth/shake', to: 'authentication#shake'
    post '/auth/login', to: 'authentication#login'
    post '/auth/refresh', to: 'authentication#refresh'

    resources :posts do
      member do
        put :like
      end
    end
  end
end
