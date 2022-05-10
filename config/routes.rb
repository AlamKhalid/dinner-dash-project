# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admins/index'
  put 'cart_items/update'
  delete 'cart_items/destroy'
  # resources :category, only: %i[create new edit update destroy]
  resources :categories
  resources :carts, only: %i[index create destroy]
  resources :orders, except: %i[new destroy] do
    put 'status_filter', on: :collection, to: 'admins#status_filter'
  end
  resources :restaurants do
    resources :items
    put 'category_filter'
  end
  devise_for :users
  root 'restaurants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
