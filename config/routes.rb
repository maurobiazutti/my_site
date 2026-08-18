Rails.application.routes.draw do
  root "about#index"
  resources :contacts, only: [ :index, :show, :new, :create ]
end
