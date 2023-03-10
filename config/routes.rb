Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post 'register', to: 'users#register'
    post 'auth/login', to: 'authentication#authenticate'
    post 'auth/logout', to: 'authentication#logout'
    post 'forgot_password' => "passwords#forgot"
    post 'reset_password' => "passwords#reset"
    resources :order_requests do
      post '/accept_offer', to: 'offers#accept_offer'
    end
    post '/get_costomer_order', to: 'order_requests#get_costomer_order'
  
    resources :organizations do
      post '/make_offer', to: 'offers#create'
      get '/get_offers', to: 'offers#get_offers'
      get '/order_requests', to: 'order_requests#index'

      resources :movers
      resources :orders do
        resources :working_times
        resources :other_works
        resources :discounts
        post '/send_receipt', to: 'orders#send_receipt'
        post '/add_worker', to: 'orders#add_worker'
        post '/remove_worker', to: 'orders#remove_worker'
      end
    end
end
