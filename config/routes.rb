Rails.application.routes.draw do
  devise_for :users

  resources :events , except: :index do
    resources :results, only: %i[index new create]
  end

  resources :wishlists, only: %i[index new create edit update]

  root to: 'events#index'
end
