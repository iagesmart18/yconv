require 'sidekiq/web'
Rails.application.routes.draw do
  root 'home#index'
  post 'home/convert'
  post 'home/poll'

  get 'home/howto'
  get 'home/service'
  get 'home/news'

  post 'home/remove'

  mount Sidekiq::Web => '/sidekiq'
end
