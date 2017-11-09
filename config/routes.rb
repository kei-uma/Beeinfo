Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get 'home/index'
  post 'edits/add'

  resources :edits
  resources :trends
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'edits#index'
  #root :to => 'home#index'
end
