# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'transactions/index'
  # get 'transactions/show'
  # get 'accounts/index'
  # get 'accounts/show'
  resources :connections, only: %i[index new show] do
    resources :accounts, only: %i[index show] do
      resources :transactions, only: %i[index show]
    end
  end
  get '/create_customer', to: 'salt_edge#create_customer'
  # get '/create_connection', to: 'salt_edge#create_connection'
  # get 'salt_edge/connections'
  # get 'salt_edge/accounts'
  # get 'salt_edge/transactions'
  devise_for :users
  root to: 'home#index'
end
