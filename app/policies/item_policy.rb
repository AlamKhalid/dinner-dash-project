# frozen_string_literal: true

class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def admin_role?
    user.role_admin?
  end

  def new?
    admin_role?
  end

  def edit?
    admin_role?
  end

  def update?
    admin_role?
  end

  def create?
    admin_role?
  end

  def destroy?
    admin_role?
  end
end
