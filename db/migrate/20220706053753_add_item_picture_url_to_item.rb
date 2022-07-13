# frozen_string_literal: true

class AddItemPictureUrlToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_picture_url, :string
  end
end
