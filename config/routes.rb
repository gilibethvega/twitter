Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :likes
  resources :tweets do
    member do
      post :retweet
      post :like
    end
  end
  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }

  post 'follow/:user_id', to: 'users#follow', as: 'users_follow'
  root 'tweets#index'
  get 'home/users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
