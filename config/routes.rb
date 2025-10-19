Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API Routes for Extreme Fitness Centre
  namespace :api do
    namespace :v1 do
      # Authentication endpoints
      post 'auth/login', to: 'auth#login'
      get 'auth/verify', to: 'auth#verify'

      # Configuration endpoints
      get 'config', to: 'config#index'
      get 'config/brand', to: 'config#brand'
      get 'config/theme', to: 'config#theme'

      # Resource endpoints
      resources :members
      resources :payments
      resources :schedules
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
