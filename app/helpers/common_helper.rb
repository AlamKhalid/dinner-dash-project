# frozen_string_literal: true

# Module for common helper
module CommonHelper
  def show_cart_badge
    current_or_guest_user.cart.nil? ? 'd-none' : 'd-block'
  end

  def cart_item_count
    current_or_guest_user&.cart&.cart_order_items&.count
  end
end
