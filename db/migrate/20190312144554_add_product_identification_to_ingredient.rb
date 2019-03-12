class AddProductIdentificationToIngredient < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :product_identification, :string
  end
end
