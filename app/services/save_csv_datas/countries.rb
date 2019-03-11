class SaveCsvDatas::Countries < SaveCsvDatas::Elements
  def self.call
    super("countries")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row["product_id"])
      row[1..-1].each do |country|
        product.countries.create(code: country)
      end
    end
  end
end
