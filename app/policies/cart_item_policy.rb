# frozen_string_literal: true

# Pundit policy for cart item
class CartItemPolicy < ApplicationPolicy
  attr_reader :user, :cart_item

  def initialize(user, cart_item)
    super
    @cart_item = cart_item
  end

  def update?
    user&.id == cart_item.cart_order.user.id
  end

  def destroy?
    user&.id == cart_item.cart_order.user.id
  end
end
