class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:full_name, :display_name, :email, :password, :phone_no, :address)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:full_name, :display_name, :email, :password, :phone_no, :address, :current_password)}
  end
end
