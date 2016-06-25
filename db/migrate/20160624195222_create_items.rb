class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :description
      t.integer :quantity, default: 0
      t.float :unitPrice
      t.float :discount, default: 0
      t.float :totalPrice
      t.belongs_to :itemable, polymorphic: true

      t.timestamps null: false
    end
    add_index :items, [:itemable_id, :itemable_type]
  end
end
