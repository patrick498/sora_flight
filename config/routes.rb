Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home" #doing this at some point

  get '/main', to: 'dashboard#main'

  resources :games, only: [:index, :show, :update]

  get '/play', to: 'games#play'

end
