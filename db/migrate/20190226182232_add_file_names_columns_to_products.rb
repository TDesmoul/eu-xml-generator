class AddFileNamesColumnsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :submitter_file_name, :string
    add_column :products, :manufacturer_file_name, :string
    add_column :products, :design_file_name, :string
  end
end
