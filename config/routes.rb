Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get 'home/index'
  post 'edits/add'
  get 'edits/list'

  resources :edits
  resources :trends
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'users#show'
  #root :to => 'home#index'
end
