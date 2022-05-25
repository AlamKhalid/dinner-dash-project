# frozen_string_literal: true

# Module for orders
module OrdersHelper
  def format_time(time)
    time.to_time.strftime('%B %e at %l:%M %p')
  end
end
