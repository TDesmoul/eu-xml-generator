Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/gogogo', to: 'pages#create_xmls', as: 'gogogo'
  get '/check_ingredients_and_emissions', to: 'pages#check_ingredients_and_emissions', as: 'check_datas'
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
