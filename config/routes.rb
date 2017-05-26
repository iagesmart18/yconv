require 'sidekiq/web'
Rails.application.routes.draw do
  root 'home#index'
  post 'home/convert'
  post 'home/poll'

  get 'home/terms'

  post 'home/remove'

  mount Sidekiq::Web => '/sidekiq'
end
