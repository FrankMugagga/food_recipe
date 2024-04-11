Rails.application.routes.draw do
  get 'inventories/index,'
  get 'inventories/show,'
  get 'inventories/new,'
  get 'inventories/create,'
  get 'inventories/destroy'
  get 'recipes/index'
  get 'recipes/show'
  get 'recipes/new'
  get 'recipes/create'
  get 'recipes/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
