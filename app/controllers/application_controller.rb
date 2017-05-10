class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :render_to_string
end
