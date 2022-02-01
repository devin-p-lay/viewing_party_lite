Rails.application.routes.draw do
  root 'welcome#index'

  get '/users/:user_id/discover', to: 'users#discover'

  get '/register', to: 'users#new'


  resources :users, only: [:create] do
    get '/dashboard', to: 'users#show'
    post '/dashboard', to: 'users#show'
  end
end
