class SaveInDb::ProductDatas < SaveInDb::Elements
  def self.call
    super("product_datas")
  end

  def self.process_row(row)
    product = Product.find_by(ref: row["product_id"]) || Product.new
    product.ref = row["product_id"]
    product.datas = row.delete_if{ |k, v| k == "product_id" }
    product.save!
  end
end
