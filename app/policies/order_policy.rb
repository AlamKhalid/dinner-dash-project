class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user
  end

  def create?
    user
  end

  def show?
    Order.find(params[:id]).user_id == user.id || user.role_admin?
  end

end
