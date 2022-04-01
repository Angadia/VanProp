Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'properties#index'

  get '/dashboard', { to: 'users#admin_panel', as: :admin_panel }

  resources :users, only:  %i[new create]

  resource :session, only: %i[new create destroy]

  resources :properties, except: [:index]
end
