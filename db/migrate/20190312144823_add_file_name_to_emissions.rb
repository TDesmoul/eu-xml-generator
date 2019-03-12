class AddFileNameToEmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :emissions, :file_name, :string
  end
end
