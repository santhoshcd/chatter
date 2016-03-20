Rails.application.routes.draw do
  resources :users
  root to: 'room#show'


  match 'auth/:provider/callback', to: 'sessions#create', :via => [:get]
  match 'auth/failure', to: redirect('/'), :via => [:get]
  match 'signout', to: 'sessions#destroy', as: 'signout', :via => [:get]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
