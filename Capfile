require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require "capistrano/rvm"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require 'capistrano/puma'
require 'capistrano/puma/jungle'
require 'capistrano/sidekiq'
require "whenever/capistrano"
# require 'capistrano/sidekiq/monit'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
