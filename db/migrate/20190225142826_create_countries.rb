class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :code
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
