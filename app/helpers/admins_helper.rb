# frozen_string_literal: true

# Module for admins
module AdminsHelper
  def orders_status_count(status)
    Order.where(status: status).count
  end

  def orders_status_options
    statuses = Order.statuses.to_a.map{ |o| [o[0].titleize, o[1]] }
    statuses.unshift(['All', -1])
    statuses
  end
end
