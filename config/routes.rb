Rails.application.routes.draw do

  root "static_pages#home"

  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :account_activations, only: [:edit]
  resources :categories, only: [:index, :show]
  resources :words, only: [:index]
  resources :users do
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
end
