Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :users, only: [:edit, :update, :show]
  root 'items#index'
    resources :address, only: [:create,:edit, :update]
  
    resources :card, only: [:new, :show] do
      collection do
        post 'show', to: 'card#show'
        post 'pay', to: 'card#pay'
        post 'delete', to: 'card#delete'
      end
    end

    resources :items  do
      resources :purchase, only: [:index] do
        collection do
          get 'index', to: 'purchase#index'
          post 'pay', to: 'purchase#pay'
          get 'done', to: 'purchase#done'
        end
      end
      collection do
        get :search
        get :search_two
        get :items_search
      end
    end
  resources :categories, only: [:new, :show]
end
