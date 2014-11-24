Tateopedia::Application.routes.draw do
  get "charges/new"
  resources :wikis
  devise_for :users

  resources :charges, only: [:new, :create]
  
  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'
end
