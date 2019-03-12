class AddNicotineDoseUptakeFileAndConsistentDosingMethodsFileToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :nicotine_dose_uptake_file, :string
    add_column :products, :consistent_dosing_methods_file, :string
  end
end
