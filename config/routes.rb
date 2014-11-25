Tateopedia::Application.routes.draw do
  get "users/index"
  get "users/new"
  get "charges/new"
  resources :wikis
  devise_for :users
    resources :users, only: [:update, :show, :index]

  resources :charges, only: [:new, :create, :destroy]


  authenticated :user do
    root to: 'wikis#index', as: 'authenticated_root'
  end
  
  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'
end
