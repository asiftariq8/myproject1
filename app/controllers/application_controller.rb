class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :disable_turbo_stream_for_devise, if: :devise_controller?

  protected

  # Redirect path after login
  def after_sign_in_path_for(resource)
    root_path
  end

  # Redirect path after sign-up
  def after_sign_up_path_for(resource)
    root_path
  end

  # Disable turbo_stream to avoid 401 errors and bad redirects
  def disable_turbo_stream_for_devise
    request.format = :html if request.format == :turbo_stream
  end

  # If you want to allow extra parameters during sign-up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
