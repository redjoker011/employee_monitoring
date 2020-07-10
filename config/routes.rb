Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  authenticate :user do
    resources :admins, only: :index
    resources :users, except: %i[create destroy]
    post 'create_user', to: 'users#create'
    delete 'remove_user/:id', to: 'users#destroy', as: :remove_user

    root "home#index"
  end
end
