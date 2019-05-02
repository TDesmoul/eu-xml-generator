class CreateAnnualSalesUpdateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :annual_sales_update_feedbacks do |t|
      t.string :missing_on_ftp
      t.string :absent_in_csv
      t.string :missing_countries

      t.timestamps
    end
  end
end
