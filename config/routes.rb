Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'properties#index'

  get '/dashboard', { to: 'users#admin_panel', as: :admin_panel }

  resources :users, only:  %i[new create]

  resource :session, only: %i[new create destroy]

  post '/applications/:id/approved', { to: 'applications#approve', as: :approve_application }
  post '/applications/:id/rejected', { to: 'applications#reject', as: :reject_application }

  resources :properties, except: [:index] do
    resources :applications, only: [:create]
    resources :questions, only: %i[create destroy update] do
      resources :answers, shallow: true, only: %i[create destroy]
    end
  end
end
