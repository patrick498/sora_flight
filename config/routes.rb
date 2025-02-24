Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home" #doing this at some point

  resources :games, only: [:show, :update]

  get '/play', to: 'games#play'

end
