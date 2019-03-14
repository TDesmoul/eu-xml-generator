Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/gogogo', to: 'pages#create_xmls', as: 'gogogo'
  get '/job_in_progress', to: 'pages#job_in_progress', as: 'job_in_progress'
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
