Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'properties#index'
  
  resources :users, only:  [:new, :create]
  
  
  
  resource :session, only: [:new, :create, :destroy]

  resources :properties, except: [:index] do
    resources :applications, only: [:create, :destroy]
    resources :questions, only: [:create, :destroy, :update] do
      resources :answers, shallow: true, only: [:create, :destroy]
    end
  end

end
