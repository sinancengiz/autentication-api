Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :games
    post '/games/:id', to: 'games#join_to_game'

    post 'signup', to: 'users#create'
    post 'auth/login', to: 'authentication#authenticate'

end
