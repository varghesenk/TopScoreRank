Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :players,only: [:index, :show, :create, :destroy]
      resources :scores, only: [:index, :show, :create, :destroy]
      get 'scores/history/:player' => 'scores#history'
    end
  end
end
