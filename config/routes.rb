Rails.application.routes.draw do
  put 'cart_items/update'
  delete 'cart_items/destroy'
  resources :carts, only: %i[index create destroy]
  resources :orders, except: %i[new edit destroy]
  resources :restaurants do
    resources :items
  end
  devise_for :users
  root 'restaurants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
