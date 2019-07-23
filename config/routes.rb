# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/sessionStatus', to: 'sessions#status'
  root to: 'application#index'

  namespace :api do
    resources :lists do
      resources :items
    end
  end

  resources :sessions
  resources :users, only: %i[new create destroy]

  mount ActionCable.server, at: '/cable'
end
