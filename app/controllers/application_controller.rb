class ApplicationController < ActionController::Base
  # Disable CSRF protection for API requests
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
end