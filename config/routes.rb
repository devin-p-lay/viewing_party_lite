Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  get '/users/:user_id/movies/:movie_id/viewing-party/new', to: 'parties#new'

  resources :users, only: [:create, :show] do
<<<<<<< HEAD
    get '/movies', to: 'movies#index'
    get '/movies/:movie_id', to: 'movies#show'
=======
    resources :movies, only: [:index, :show]
>>>>>>> e1740152cca8cecf94e585b7e2fe1dd3f462075f
    get '/discover', to: 'users#discover'
    get '/dashboard', to: 'users#show'
    post '/dashboard', to: 'users#show'
  end
end
