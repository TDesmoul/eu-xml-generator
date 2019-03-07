class AddPresentationFileNameToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :presentation_file_name, :string
  end
end
