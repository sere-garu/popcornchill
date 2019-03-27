Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }

  resources :events , except: :index do
    resources :results, only: %i[index create]
  end

  resources :wishlists, only: %i[index create destroy]
  resources :user_events, only: %i[update destroy]
  get '/popit', to: 'pages#home'

  root to: 'events#index'
end
