Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  authenticate :user do
    root "home#index"

    resources :users, except: %i[create destroy]
    post 'create_user', to: 'users#create'
    delete 'remove_user/:id', to: 'users#destroy', as: :remove_user
  end
end
