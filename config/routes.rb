Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :rooms, only: %i[show create destroy]#, param: :title
  resources :messages, only: %i[create update edit destroy]
  root "rooms#index"
end
