Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "about#index"
  resources :contacts, only: [ :index, :show, :new, :create ]
  resources :categories
  resources :articles
end
