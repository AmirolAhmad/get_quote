class AddSlugToTable < ActiveRecord::Migration
  def change
    add_column :quotations, :slug, :string, unique: true
    add_column :clients, :slug, :string, unique: true
  end
end
