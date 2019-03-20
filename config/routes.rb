Rails.application.routes.draw do
  devise_for :users

  resources :events , except: :index do
    resources :results, only: %i[index create]
  end

  resources :wishlists, only: %i[index new create edit update]
  resources :user_events, only: :update

  root to: 'events#index'
end
