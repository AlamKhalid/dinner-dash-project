# frozen_string_literal: true

# Application controller, main controller from which all controller inherits
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def render_not_found_template
    respond_to do |format|
      format.html { render file: Rails.root.join('public/404.html'), layout: false, status: :not_found }
      format.json { render json: { error: 'Resource not found' }, status: :not_found }
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    redirect_back(fallback_location: root_path)
  end

  def transfer_guest_to_user
    # At this point you have access to:
    #   * current_user - the user they've just logged in as
    #   * guest_user - the guest user they were previously identified by
    #
    # After this block runs, the guest_user will be destroyed!
    return if guest_user.cart.nil?

    if Cart.find_by(user_id: current_user.id)
      Cart.find_by(id: guest_user.cart.id).destroy
      return
    end

    guest_user.cart.update(user_id: current_user.id)
  end

  def guest_user_params
    {
      full_name: 'guest'
    }
  end
end
