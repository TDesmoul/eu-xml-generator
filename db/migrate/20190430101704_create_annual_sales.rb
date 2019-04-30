class CreateAnnualSales < ActiveRecord::Migration[5.2]
  def change
    create_table :annual_sales do |t|
      t.string :file_id
      t.integer :year
      t.string :country
      t.float :sales

      t.timestamps
    end
  end
end
