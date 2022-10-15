Rails.application.routes.draw do
  resources :items, only: [:index, :create]

  # nested routes showing a user and it's related items
  resources :users, only: [:show] do 
    resources :items, only: [:show, :index, :create]
  end
end
