Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tweets#index"

  # Tweets
  get 'tweets/drafts', to: 'tweets#drafts'
  post 'tweets/:id/publish', to: 'tweets#publish', as: 'publish_tweet'
  resources :tweets

  # Users & Login
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
