# frozen_string_literal: true

# Pundit policy for cart
class CartPolicy < ApplicationPolicy
  attr_reader :user, :cart

  def initialize(user, cart)
    super
    @cart = cart
  end

  def destroy?
    user.id == cart.user.id
  end
end
