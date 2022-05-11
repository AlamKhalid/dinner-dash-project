# frozen_string_literal: true

# Pundit policy for restaurant
class RestaurantPolicy < ApplicationPolicy
  def admin_role?
    user.role_admin?
  end
end
