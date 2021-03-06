Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts, shallow: true do
    resources :comments, only: [ :create, :destroy ], shallow: true do
      resources :comments, only: [ :create, :destroy ]
    end
    resources :likes, only: :create
  end

  resources :relationships, only: [ :index, :create ]
  get '/search', to: 'relationships#search', as: 'search'
  patch '/cancel/:id', to: 'relationships#cancel', as: 'cancel_relationship'
  patch '/accept/:id', to: 'relationships#accept', as: 'accept_relationship'
  patch '/decline/:id', to: 'relationships#decline', as: 'decline_relationship'
  get '/user/:username', to: 'users#show', as: 'user'

  resources :notifications do
    collection do
      patch :mark_as_read
    end
  end

  resources :chats, only: :index

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :chatrooms, only: [ :index, :show ] do
        resources :messages, only: :create
      end
    end
  end

  mount ActionCable.server => "/cable"

end
