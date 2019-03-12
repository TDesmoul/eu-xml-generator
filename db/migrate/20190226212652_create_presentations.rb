class CreatePresentations < ActiveRecord::Migration[5.2]
  def change
    create_table :presentations do |t|
      t.references :product, foreign_key: true
      t.json :datas

      t.timestamps
    end
  end
end
