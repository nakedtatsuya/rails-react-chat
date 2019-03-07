Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'auth/registrations'
  }
  get '/users/friends', to: 'users#friend', format: 'json'
  resources :users, only: [:index, :show], format: 'json'
  resources :friendships, only: [:create, :destroy], format: 'json'
  resources :messages, only: [:create], format: 'json'
  get '/messages/:id', to: 'messages#index', format: 'json'
  post '/messages/image/:to_id', to: 'messages#image', format: 'json'
  put '/users/image', to: 'users#image', format: 'json'
end
