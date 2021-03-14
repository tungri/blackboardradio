Rails.application.routes.draw do

  get 'comments/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tweets#index"

  # Tweets
  get 'tweets/drafts', to: 'tweets#drafts'
  get 'tweets/attachments/:filename', to: 'tweets#attachments', as: 'tweet_attachments'
  post 'tweets/:id/publish', to: 'tweets#publish', as: 'publish_tweet'
  post 'tweets/:id/like', to: 'tweets#like', as: 'like_tweet'
  resources :tweets do
    post 'comments/:id/like', to: 'comments#like', as: 'like_comment'
    resources :comments
  end

  # Users & Login
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
