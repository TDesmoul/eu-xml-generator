class SaveInDb::Countries < SaveInDb::Elements
  def self.call
    super("countries")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row["product_id"])
      product.countries.create(code: row["NationalMarket"])
    end
  end
end
