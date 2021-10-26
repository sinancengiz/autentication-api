Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :games
    get '/games/:id/users', to: 'games#get_game_users'
    post '/games/:id', to: 'games#join_to_game'
    post '/games/:id/quit_game', to: 'games#quit_from_game'
    post '/games/:id/start_game', to: 'games#start_game'

    post 'signup', to: 'users#create'
    post 'auth/login', to: 'authentication#authenticate'
    post 'auth/logout', to: 'authentication#logout'
end
