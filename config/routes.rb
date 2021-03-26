Rails.application.routes.draw do
  resources :likes
  resources :tweets
  root 'home#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
end
