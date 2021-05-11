Rails.application.routes.draw do
  resources :round
  resources :room

  root to: 'home#index'
end
