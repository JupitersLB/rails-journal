Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :relationships, only: [ :index, :create ]
  get '/search', to: 'relationships#search', as: 'search'
  patch '/cancel/:id', to: 'relationships#cancel', as: 'cancel_relationship'
  patch '/accept/:id', to: 'relationships#accept', as: 'accept_relationship'
  patch '/decline/:id', to: 'relationships#decline', as: 'decline_relationship'
  get '/:username', to: 'users#show', as: 'user'

end
