# frozen_string_literal: true

class Order < CartOrder
  validates :user_id, presence: true
  validates :cart_order_items, length: { minimum: 1 }

  enum status: {
    ordered: 0,
    paid: 1,
    cancelled: 2,
    completed: 3
  }, _prefix: true
end
