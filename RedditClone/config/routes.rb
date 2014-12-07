Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :comments, :only => [:create, :destroy] do
    get 'upvote', to: 'comments#upvote', as: :upvote
    get 'downvote', to: 'comments#downvote', as: :downvote
    get 'reply', to: "comments#reply", as: :reply
  end

  get '/r/:community', to: 'posts#index', as: :community_by_name
  get '/r/:community/subscribe', to: 'community#subscribe', as: :community_subscribe
  get '/r/:community/:id', to: 'posts#show', as: :post_by_title

  resources :communities do
    resources :community_users
  end

  resources :posts do
    resources :post_votes
    get 'upvote', to: 'posts#upvote', as: :upvote
    get 'downvote', to: 'posts#downvote', as: :downvote
  end

  root 'posts#index'

end
