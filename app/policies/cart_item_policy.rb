class CartItemPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :cart_item

  def initialize(user, cart_item)
    super
    @cart_item = cart_item
  end

  def update?
    user.id == cart_item.cart_order.user.id
  end

  def destroy?
    user.id == cart_item.cart_order.user.id
  end
end
