class AddDatasToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :datas, :json
  end
end
