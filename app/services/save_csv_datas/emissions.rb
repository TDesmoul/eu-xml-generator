class SaveCsvDatas::Emissions < SaveCsvDatas::Elements
  def self.call
    super("emissions")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row["product_id"])
      product.emissions.create(cas:      row["CasNumber"],
                               quantity: row["RecipeQuantity"])
    end
  end
end
