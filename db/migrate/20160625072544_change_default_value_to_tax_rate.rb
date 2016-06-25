class ChangeDefaultValueToTaxRate < ActiveRecord::Migration
  def change
    change_column :quotations, :taxRate, :float, default: 0
  end
end
