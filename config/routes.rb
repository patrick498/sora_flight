Rails.application.routes.draw do
  devise_for :users
  root to: "dashboard#home" #doing this at some point

  resources :games, only: [:index, :show, :update]

  get '/play', to: 'games#play'

end
