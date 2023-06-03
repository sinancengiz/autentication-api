Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post 'auth/signup', to: 'users#signup'
    post 'auth/login', to: 'authentication#authenticate'
    post 'auth/logout', to: 'authentication#logout'
    post 'auth/forgot_password' => "passwords#forgot"
    post 'auth/reset_password' => "passwords#reset"
end
