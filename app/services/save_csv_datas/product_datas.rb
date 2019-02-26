class SaveCsvDatas::ProductDatas < SaveCsvDatas::Elements
  def self.call
    super("product_datas")
  end

  def self.process_row(row)
    product = Product.find_by(ref: row["product_id"]) || Product.new
    product.submitter_file_name = row.delete("submitter_file_name")
    product.manufacturer_file_name = row.delete("manufacturer_file_name")
    product.design_file_name = row.delete("design_file_name")
    product.ref = row.delete("product_id")
    product.datas = row
    product.save!
  end
end
