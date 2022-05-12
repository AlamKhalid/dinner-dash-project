# frozen_string_literal: true

# Pundit policy for restaurant
class RestaurantPolicy < ApplicationPolicy
  # scope
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def admin_role?
    user&.role_admin?
  end
end
