source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'sidekiq'
gem 'sidekiq-unique-jobs', github: 'mhenrixon/sidekiq-unique-jobs'
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'angularjs-rails'
gem 'gon'
gem "paperclip", "~> 5.0.0"
gem 'aasm'
gem "figaro"
gem "font-awesome-rails"
gem 'whenever', :require => false
gem 'streamio-ffmpeg'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem "letter_opener"
  gem 'capistrano3-puma'
  gem 'capistrano-sidekiq'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-ngtoast'
  gem 'rails-assets-angular-sanitize'
  gem 'rails-assets-angular-animate'
end
