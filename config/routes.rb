Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/friends'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :tweets do
    post :repost
    post :friend
    delete :unfriend
    resources :likes
  end
end
