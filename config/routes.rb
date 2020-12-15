Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resource :session, only: %i[new create destroy]
  resources :questions, except: %i[new index show]
  resources :hashtags, only: %i[index show]
end
