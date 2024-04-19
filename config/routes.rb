Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :recipes do
    resources :recipe_foods
  end

  resources :inventories do
    resources :inventory_foods
  end

  resources :foods do
    resources :inventory_foods
    resources :recipe_foods
  end

  resources :users, only: [:index]
end
