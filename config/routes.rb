Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post 'register', to: 'users#register'
    post 'auth/login', to: 'authentication#authenticate'
    post 'auth/logout', to: 'authentication#logout'
    post 'forgot_password' => "passwords#forgot"
    post 'reset_password' => "passwords#reset"
end
