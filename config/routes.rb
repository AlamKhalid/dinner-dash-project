Rails.application.routes.draw do
  resources :restaurants
  devise_for :users
  root 'restaurants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
