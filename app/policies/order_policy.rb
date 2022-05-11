# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :order

  def initialize(user, order)
    super
    @order = order
  end

  def index?
    user
  end

  def create?
    user
  end

  def edit?
    user.role_admin?
  end

  def update?
    user.role_admin?
  end

  def show?
    return true if user.role_normal? && order.user_id == user.id
    return true if user.role_admin?

    false
  end
end
