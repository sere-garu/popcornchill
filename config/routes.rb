Rails.application.routes.draw do
  devise_for :users

  resources :events , except: :index do
    resources :results, only: %i[new create show]
  end

  resources :wishlists, only: %i[index new create edit update]

  root to: 'events#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
