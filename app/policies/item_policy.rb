# frozen_string_literal: true

# Pundit policy for items
class ItemPolicy < ApplicationPolicy
  def admin_role?
    user.role_admin?
  end
end
