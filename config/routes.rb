Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  authenticate :user do
    resources :users, except: %i[create destroy]
    resources :leave_requests, except: %i[edit update show destroy] do
      member do
        post "approve_request", to: "leave_requests#approve"
        post "decline_request", to: "leave_requests#decline"
      end
    end

    post 'create_user', to: 'users#create'
    delete 'remove_user/:id', to: 'users#destroy', as: :remove_user

    root "home#index"
  end
end
