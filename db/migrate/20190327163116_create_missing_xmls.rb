class CreateMissingXmls < ActiveRecord::Migration[5.2]
  def change
    create_table :missing_xmls do |t|
      t.string :xml_type
      t.string :elements

      t.timestamps
    end
  end
end
