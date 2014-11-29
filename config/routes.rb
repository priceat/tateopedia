Tateopedia::Application.routes.draw do
  get "users/index"
  get "users/new"
  get "charges/new"
  get "wikis/private_index"
  get "wikis/my_index"

  devise_for :users 
    resources :wikis, only: [:new, :update, :edit, :create, :show, :index, :private_index, :my_index, :destroy] do
      resources :collaborators
    end

    resources :users, only: [:update, :show, :index]

  resources :charges, only: [:new, :create, :destroy]

  authenticated :user do
    root to: 'wikis#index', as: 'authenticated_root'
  end
  
  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'
end
