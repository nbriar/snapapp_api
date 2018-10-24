Rails.application.routes.draw do
  root to: "home#index"

  resources :customer_apps do
    resources :pages
  end

  namespace :auth do
    resources :accounts
    resources :users
  end

  resources :collections
  resources :components
  resources :contents
  resources :elements, only: [:index, :show]
  resources :tags
  resources :templates

  post "/attachments/create", to: "attachments#create"
  post "/attachments/delete", to: "attachments#destroy"

  post "/graphql", to: "graphql#execute"

end
