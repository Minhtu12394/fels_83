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
  resources :words, only: [:index]
  resources :categories, only: [:index, :show] do
    resources :lessons, only: [:create]
  end
  resources :lessons, only: [:show, :update, :destroy]
  
  resources :users, except: [:destroy] do
    get ":relationship_type" => "relationships#index", as: :relationships,
      constraints: {relationship_type: /(following|followers)/}
  end

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :destroy]
    resources :categories do
      resources :words, except: [:index, :show]
    end
    resources :lessons, only: [:index, :destroy]
  end
end
