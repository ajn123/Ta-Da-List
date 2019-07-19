# frozen_string_literal: true

Rails.application.routes.draw do
  get 'lists/index'
  get 'lists/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #

  root 'lists#index'

  namespace :api do
    resources :lists do
      resources :items
    end
  end

  resources :sessions
  resources :users, only: [:new, :create, :destroy]

  mount ActionCable.server, at: '/cable'
end
