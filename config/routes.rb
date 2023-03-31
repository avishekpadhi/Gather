Rails.application.routes.draw do
  get 'search', to: 'profiles#search'
  resources :interests
  
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'

  }
  as :user do

    get "signin" => 'devise/sessions#new'
    delete "signout" => 'devise/sessions#destroy'



  end

  resources :users,only: [:show]

  post 'users/:id/follow', to:"users#follow", as: "follow"
  post 'users/:id/unfollow', to:"users#unfollow", as: "unfollow"
  post 'users/:id/accept', to:"users#accept", as: "accept"
  post 'users/:id/decline', to:"users#decline", as: "decline" 
  post 'users/:id/cancel', to:"users#cancel", as: "cancel"
  
  root to: 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
