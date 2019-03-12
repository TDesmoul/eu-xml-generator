class RemoveProductIdentificationToIngredient < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :product_identification
  end
end
