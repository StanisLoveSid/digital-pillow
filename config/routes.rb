Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :book_attachments
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  resources :users
  root "books#index"
 
  resources :categories

  resources :books do
    resources :reviews
  end
  resources :authors
  resources :prices
  resources :checkouts
  resources :orders
  get "/cart", to: "orders#edit"
  resources :order_items, only: [:create, :update, :destroy]
  get "/order_items/:id", to: "order_items#discount"
  get '/checkouts/address', to: "users#address"
  post '/checkouts/confirm', to: "privates#scanner"
  get '/resume_not_comleted_order', to: 'orders#resume_not_comleted_order'
  get "*path" => redirect("/")
end
