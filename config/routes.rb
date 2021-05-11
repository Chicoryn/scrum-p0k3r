Rails.application.routes.draw do
  resources :room, only: [:create, :show] do
    resources :participant, only: [:new, :create]
    resources :round, only: [:create] do
      resources :vote, only: [:create]

      member do
        post :reset
        post :unseal
      end
    end

    member do
      get :current_standing
      get :join
    end
  end

  root to: 'home#index'
end
