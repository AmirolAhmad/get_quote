class ChangeDefaultValueFromQuantity < ActiveRecord::Migration
  def change
    change_column :items, :quantity, :integer, default: 1
  end
end
