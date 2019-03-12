class AddProductIdentificationToEmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :emissions, :product_identification, :string
  end
end
