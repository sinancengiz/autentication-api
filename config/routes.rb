Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :games
    post '/games/:id', to: 'games#join_to_game'
    get '/games/:id/users', to: 'games#get_game_users'
    post '/games/:id/users/:user_id', to: 'games#quit_from_game'

    post 'signup', to: 'users#create'
    post 'auth/login', to: 'authentication#authenticate'

end
