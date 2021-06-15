Rails.application.routes.draw do
  root 'books#top'
  devise_for :users
  get '/home/about' => 'users#about'
  #get '/users'    => 'users#users'
  # get '/books' => 'books#show'
  # get '/books' => 'users#books'
  resources :users
  resources :books do
    resource :favorite, only:[:create, :destroy]
  end
  get '/search' => 'searches#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
