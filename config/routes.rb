Rails.application.routes.draw do
  get 'lists/index'
  get 'lists/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #


  root "lists#index"

  namespace :api do
    resources :lists do
      resources :items
    end
  end
end
