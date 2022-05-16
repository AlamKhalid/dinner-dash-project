# frozen_string_literal: true

# Application controller, main controller from which all controller inherits
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Not authorized to perform this action'
    redirect_back(fallback_location: new_user_session_path)
  end

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:full_name, :display_name, :email, :password, :password_confirmation, :phone_no, :address)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:full_name, :display_name, :email, :password, :password_confirmation, :phone_no, :address,
               :current_password)
    end
  end

  private

  def transfer_guest_to_user
    # At this point you have access to:
    #   * current_user - the user they've just logged in as
    #   * guest_user - the guest user they were previously identified by
    #
    # After this block runs, the guest_user will be destroyed!
    return if guest_user.cart.nil?

    guest_user.cart.update(user_id: current_user.id)
  end

  def guest_user_params
    {
      full_name: 'guest'
    }
  end
end
