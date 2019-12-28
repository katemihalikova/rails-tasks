class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def redirect_before_form(opts = {})
    redirect_to session.delete(:return_to) || opts[:fallback_location], opts
  end

  def save_previous_page
    session[:return_to] = request.referer
  end
end
