Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :tweets do
    post :repost
    resources :likes
  end
end
