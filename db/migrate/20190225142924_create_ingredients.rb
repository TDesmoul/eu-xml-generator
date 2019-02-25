class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :cas
      t.float :quantity
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
