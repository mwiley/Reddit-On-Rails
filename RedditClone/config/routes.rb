Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :comments, :only => [:create, :destroy, :show] do
    get 'upvote', to: 'comments#upvote', as: :upvote
    get 'downvote', to: 'comments#downvote', as: :downvote
    get 'reply', to: "comments#reply", as: :reply
  end

  get '/r/:community', to: 'posts#index', as: :community_by_name
  get '/r/:community/:id', to: 'posts#show', as: :post_by_title

  resources :communities do
    resources :community_users
    get 'subscribe', to: 'communities#subscribe', as: :subscribe
  end

  resources :posts do
    resources :post_votes
    get 'upvote', to: 'posts#upvote', as: :upvote
    get 'downvote', to: 'posts#downvote', as: :downvote
  end

  root 'posts#index'

end
