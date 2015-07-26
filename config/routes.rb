Rails.application.routes.draw do

  root to: "home#index"

  devise_for :users

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  resources :users, only: [:index] do
    patch "downgrade"
    resources :wikis
  end

  resources :charges, only: [:new, :create]

end
