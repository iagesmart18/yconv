require 'sidekiq/web'
Rails.application.routes.draw do
  root 'home#index'
  post 'home/convert'
  post 'home/poll'

  get 'home/howto'
  get 'home/service'
  get 'home/news'

  mount Sidekiq::Web => '/sidekiq'
end
