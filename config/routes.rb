Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users

  get 'session/new', to: 'sessions#new'
  delete '/sign_out', to: 'sessions#destroy'
  resources :sessions, only: [:create]
end
