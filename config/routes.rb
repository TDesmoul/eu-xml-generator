Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/gogogo', to: 'pages#create_xmls', as: 'gogogo'
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
