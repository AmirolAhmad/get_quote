class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :recipientId
      t.string :quoteId, unique: true
      t.datetime :validUntil
      t.integer :status, default: 0
      t.float :subTotal
      t.float :taxRate
      t.float :tax
      t.float :total
      t.text :note

      t.timestamps null: false
    end
  end
end
