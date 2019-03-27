class SaveCsvDatas::Ingredients < SaveCsvDatas::Elements
  def self.call
    super("ingredients")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row.delete("product_id"))
      puts "Création d'un nouvel ingerdient pour #{product.ref}"
      product.ingredients.create(
        cas:       row["CasNumber"],
        quantity:  row["RecipeQuantity"],
        file_name: IngredientLocation.find_by(cas: row["CasNumber"]).file,
        datas:     row
      )
    end
  end
end
