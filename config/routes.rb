Rails.application.routes.draw do
  get 'chats/show'
  root 'books#top'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/home/about' => 'users#about'
  #get '/users'    => 'users#users'
  # get '/books' => 'books#show'
  # get '/books' => 'users#books'
  resources :users do
    member do
      get :following, :follower
    end
  end
  resources :books do
    resource :favorite, only:[:create, :destroy]
  end
  get '/search' => 'searches#search'
  resources :relationships, only:[:create, :destroy]
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
