Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :rooms, only: %i[show create]#, param: :title
  resources :messages, only: %i[create update edit destroy] do
    member { post :like }
  end
  root "rooms#index"
end
