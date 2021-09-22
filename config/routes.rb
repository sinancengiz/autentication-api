Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :games
    
    post 'signup', to: 'users#create'
    post 'auth/login', to: 'authentication#authenticate'

end
