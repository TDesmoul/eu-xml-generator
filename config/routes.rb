Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/gogogo', to: 'pages#create_xmls', as: 'gogogo'
  get '/check_ingredients_and_emissions', to: 'pages#check_ingredients_and_emissions', as: 'check_datas'
  get '/add_annual_sales', to: 'pages#add_annual_sales', as: 'add_annual_sales'
  get '/destroy_feedback', to: 'pages#destroy_feedback', as: 'destroy_feedback'
  post '/add_countries', to: 'pages#add_counties', as: 'add_countries'
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount ActionCable.server => "/cable"
end
