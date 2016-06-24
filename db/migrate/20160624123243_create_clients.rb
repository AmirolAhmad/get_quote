class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :clientId, unique: true
      t.string :contactPerson
      t.string :companyName
      t.string :companyAddress
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
