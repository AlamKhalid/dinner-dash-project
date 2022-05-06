class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :int, default: 0 # 0 means user, 1 means admin
    add_column :users, :full_name, :string, null: false
    add_column :users, :display_name, :string
    add_column :users, :phone_no, :string, null: false
    add_column :users, :address, :string, null: false
  end
end
