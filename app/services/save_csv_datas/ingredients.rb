class SaveCsvDatas::Ingredients < SaveCsvDatas::Elements
  def self.call
    super("ingredients")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row.delete("product_id"))
      product.ingredients.create(cas:      row["CasNumber"],
                                 quantity: row["RecipeQuantity"],
                                 datas:    row)
    end
  end
end
