Rails.application.routes.draw do

  get 'home/about' => 'homes#about'

  get 'relationships' => 'relationships#index'

  get 'follows' => 'relationships#follower'

  get 'followers' => 'relationships#followed'

  root 'homes#top'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

end