Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get 'home/index'
  get "edits/index"
  post 'edits/add'

  resources :edits
  resources :trends
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'users#show'
  #root :to => 'home#index'
end
