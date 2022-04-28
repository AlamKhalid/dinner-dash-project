class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.decimal :price, precision: 5, scale: 2
      t.boolean :retired, default: false
      t.references :restaurant, foreign_key: true

      t.timestamps
    end

    create_table :categories_items, id: false do |t|
      t.belongs_to :category
      t.belongs_to :item
    end
  end
end
