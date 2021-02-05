Rails.application.routes.draw do
  resources :tweets do
    member do
      post :retweet
    end
  end
  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
