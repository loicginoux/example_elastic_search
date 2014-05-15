class AddTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :prod_type, :integer
    add_column :products, :brand_id, :integer
  end
end
