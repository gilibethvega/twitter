Rails.application.routes.draw do
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
  #followers and unfollowers
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  #root
  root 'tweets#index'
  #profile de user
  get 'home/profile'
  #lista de users
  get 'home/users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
