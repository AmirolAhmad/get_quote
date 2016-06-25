class RemoveDiscountFromItem < ActiveRecord::Migration
  def change
    remove_column :items, :discount, :float
  end
end
