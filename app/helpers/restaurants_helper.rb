# frozen_string_literal: true

# Module for restaurants
module RestaurantsHelper
  def category_options
    categories_array = Category.order(:name).map { |c| [c.name] }
    categories_array.unshift(%w[Popular popular])
    categories_array.unshift(%w[All all])
    categories_array
  end
end
