class AddIngredientsFileNameToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :file_name, :string
  end
end
