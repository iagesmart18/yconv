require 'sidekiq/web'
Rails.application.routes.draw do
  root 'home#index'
  post 'home/convert'
  mount Sidekiq::Web => '/sidekiq'
end
