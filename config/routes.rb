Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "/follow/:id", to: "follows#create", as: "follow_user"
  delete "/unfollow/:id", to: "follows#destroy", as: "unfollow_user"
  root "posts#index"
  resources :posts do
    resources :comments, only: [ :create, :destroy ] do
      resource :like, only: [ :create, :destroy ], controller: "comment_likes"
    end
    resource :like, only: [ :create, :destroy ], controller: "post_likes"
    resources :reposts, only: [ :create, :destroy ]
  end

  resources :users, only: [ :show ] do
    collection do
      get :search
    end
    member do
      get "/followers", to: "users#followers", as: :user_followers
      get "/following", to: "users#following", as: :user_following
    end
    resource :follow, only: [ :create, :destroy ]
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
