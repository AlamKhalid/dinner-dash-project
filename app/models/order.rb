# frozen_string_literal: true

class Order < CartOrder
  enum status: {
    ordered: 0,
    paid: 1,
    cancelled: 2,
    completed: 3
  }, _prefix: true

  scope :all_orders, -> { includes(:user, :restaurant).order(:id).all }
  scope :with_status, ->(status) { includes(:user, :restaurant).order(:id).where(status: status).all }
  scope :for_user, ->(uid) { includes(:restaurant, :cart_order_items).order(created_at: :desc).where(user_id: uid) }
end
