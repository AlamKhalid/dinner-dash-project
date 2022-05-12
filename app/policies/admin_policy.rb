# frozen_string_literal: true

# Pundit policy for admins
class AdminPolicy < ApplicationPolicy
  # scope
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user&.role_admin?
  end
end
