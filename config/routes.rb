Tateopedia::Application.routes.draw do

  get "wikis/private_index"
  get "wikis/my_index"
  get "wikis/collaborations_index"

  devise_for :users 

  resources :wikis do
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
