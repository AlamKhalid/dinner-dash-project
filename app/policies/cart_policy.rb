class CartPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :cart

  def initialize(user, cart)
    super
    @cart = cart
  end

  def destroy?
    user.id == cart.user.id
  end
end
