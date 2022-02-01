Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'

  resources :users, only: [:create] do
    get '/dashboard', to: 'users#show'
    post '/dashboard', to: 'users#show'
  end
end
