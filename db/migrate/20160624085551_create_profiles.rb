class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :firstName
      t.string :lastName
      t.string :phoneNumber
      t.string :accountType
      t.string :businessName
      t.text :businessAddress
      t.string :businessRegNumber
      t.string :csPhoneNumber
      t.string :businessTaxRegNumber

      t.timestamps null: false
    end
  end
end
