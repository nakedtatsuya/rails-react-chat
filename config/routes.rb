Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}, format: 'json'
  root to: "users#index"
  resources :users, only: [:index, :create, :destroy], format: 'json'
  post '/users/login', to: 'users#login', format: 'json'
end
