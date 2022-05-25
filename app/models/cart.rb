# frozen_string_literal: true

class Cart < CartOrder
  validates :user_id, uniqueness: true
end
