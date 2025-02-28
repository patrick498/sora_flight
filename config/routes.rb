Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "pages#home" #doing this at some point

  get '/main', to: 'dashboard#main'

  resources :games, only: [:index, :show, :update, :create ]

  get '/play', to: 'games#play', as: :game_play
  get '/setup', to: 'games#setup', as: :setup
  get '/load_game', to: 'games#load_game', as: :game_load

  # Routes for PWA
  get "/service-worker.js", "service_worker#service_worker", as: :service_worker
  get "/manifest.json", "service_worker#manifest", as: :manifest

end
