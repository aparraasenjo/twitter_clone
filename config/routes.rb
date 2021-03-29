Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :tweets do
    resources :likes
  end

end
