# frozen_string_literal: true

class Order < CartOrder
  validates :status, inclusion: 0..3

  enum status: {
    ordered: 0,
    paid: 1,
    cancelled: 2,
    completed: 3
  }, _prefix: true
end
