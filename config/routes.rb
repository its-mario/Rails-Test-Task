Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/show'
  get 'accounts/index'
  get 'accounts/show'
  resources :connections, only: [:index, :new, :show] do
    resources :accounts, only: [:index, :show] do
      resources :transactions, only: [:index, :show]
    end
  end
  get '/create_customer', to: 'salt_edge#create_customer'
  #get '/create_connection', to: 'salt_edge#create_connection'
  #get 'salt_edge/connections'
  #get 'salt_edge/accounts'
  #get 'salt_edge/transactions'
  devise_for :users
  root to: 'home#index'
end
