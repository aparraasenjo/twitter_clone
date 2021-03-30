Rails.application.routes.draw do
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
