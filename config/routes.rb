Rails.application.routes.draw do
  devise_for :users
  resources :admins, only: :index
  resources :users, except: %i[create destroy]
  post 'create_user', to: 'users#create'
  delete 'remove_user/:id', to: 'users#destroy', as: :remove_user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
