Rails.application.routes.draw do
  resources :edits
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'edits#index'
end
