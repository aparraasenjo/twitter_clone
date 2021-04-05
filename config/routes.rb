Rails.application.routes.draw do
  get 'api/news', to: 'api#index'
  get 'api/:start_date/:end_date', to: 'api#show'
  post 'api/tweets', to: 'api#create'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'home/friends'
  get '/home/hashtag/:name', to: 'home#hashtags'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :tweets do
    post :repost
    post :friend
    delete :unfriend
    resources :likes
  end
end

