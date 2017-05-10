require 'sidekiq/web'
Rails.application.routes.draw do
  root 'home#index'
  post 'home/convert'
  post 'home/poll'

  mount Sidekiq::Web => '/sidekiq'
end
