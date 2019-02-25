class CreateEmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :emissions do |t|
      t.string :cas
      t.float :quantity
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
