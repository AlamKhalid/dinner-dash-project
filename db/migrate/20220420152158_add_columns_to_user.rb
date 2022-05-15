# frozen_string_literal: true

class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :int, default: 0 # 0 means user, 1 means admin
    add_column :users, :full_name, :string, null: false
    add_column :users, :display_name, :string
    add_column :users, :phone_no, :string
    add_column :users, :address, :string

    add_check_constraint :users, 'check_column_name IN (0, 1)', name: 'check_constraint_status'
  end
end
