Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  get '/users/:user_id/movies/:movie_id/viewing-party/new', to: 'parties#new'

  resources :users, only: [:create, :show] do
    # get '/movies', to: 'movies#index'
    # get '/movies/:movie_id', to: 'movies#show'
    resources :movies, only: [:index, :show]
    get '/discover', to: 'users#discover'
    get '/dashboard', to: 'users#show'
    post '/dashboard', to: 'users#show'
  end
end
