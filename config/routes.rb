Rails.application.routes.draw do
  get 'admins/index'
  put 'cart_items/update'
  delete 'cart_items/destroy'
  resources :category, only: %i[create new edit update]
  resources :carts, only: %i[index create destroy]
  resources :orders, except: %i[new destroy]
  resources :restaurants do
    resources :items
    put 'category_filter'
  end
  devise_for :users
  root 'restaurants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
