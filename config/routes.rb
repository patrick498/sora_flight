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

  #test
  get '/index', to: 'pages#home'

end
