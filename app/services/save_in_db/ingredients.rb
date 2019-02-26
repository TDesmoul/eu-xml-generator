class SaveInDb::Ingredients < SaveInDb::Elements
  def self.call
    super("ingredients")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row["product_id"])
      product.ingredients.create(cas:    row["CasNumber"],
                               quantity: row["RecipeQuantity"])
    end
  end
end
