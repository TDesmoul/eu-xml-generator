class CreateEmissionLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :emission_locations do |t|
      t.string :cas
      t.string :file

      t.timestamps
    end
  end
end
