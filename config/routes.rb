Rails.application.routes.draw do

  root 'weather#index'
  resources :weather, only: [:index, :new, :show, :create]
end
