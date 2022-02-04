Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new'
  resources :users, only: [:create, :show] do
    resources :movies, only: [:index, :show] do
      resources :parties, only: [:new, :create]
    end
    get '/discover', to: 'users#discover'
    get '/dashboard', to: 'users#show'
    post '/dashboard', to: 'users#show'
  end
end
