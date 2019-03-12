class AddUuidInProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :uuid, :string
  end
end
