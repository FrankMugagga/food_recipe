Rails.application.routes.draw do
  get 'recipe_foods/index'
  get 'recipe_foods/show'
  get 'recipe_foods/new'
  get 'recipe_foods/create'
  get 'recipe_foods/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users do
    resources :inventories
    resources :recipes
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
end
