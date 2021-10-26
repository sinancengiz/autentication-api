Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :games
    get '/games/:id/users', to: 'games#get_game_users'
    post '/games/:id/join_game', to: 'games#join_to_game'
    post '/games/:id/quit_game', to: 'games#quit_from_game'
    post '/games/:id/start_game', to: 'games#start_game'
    post '/games/:id/select_capital', to: 'games#select_capital'
    post '/games/:id/select_color', to: 'games#select_color'

    post 'signup', to: 'users#create'
    post 'auth/login', to: 'authentication#authenticate'
    post 'auth/logout', to: 'authentication#logout'
end
