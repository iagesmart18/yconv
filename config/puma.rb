if ENV.fetch("RAILS_ENV") == 'prouduction'
  app_dir = File.expand_path("../..", __FILE__)
  shared_dir = "#{app_dir}/shared"

  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
  threads threads_count, threads_count
  port        ENV.fetch("PORT") { 3000 }

  environment ENV.fetch("RAILS_ENV") { "development" }
  preload_app!

  bind "unix://#{shared_dir}/sockets/puma.sock"
# Logging
  stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
  pidfile "#{shared_dir}/pids/puma.pid"
  state_path "#{shared_dir}/pids/puma.state"
  activate_control_app

  plugin :tmp_restart
end
