Rails.application.routes.draw do
  devise_for :users
  resources :admins, only: :index
  resources :users, except: :create
  post 'create_user', to: 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
