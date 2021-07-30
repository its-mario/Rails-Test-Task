# frozen_string_literal: true

class AddCustomerIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :customer_id, :string
  end
end
