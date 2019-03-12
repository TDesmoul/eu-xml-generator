class SaveCsvDatas::Ingredients < SaveCsvDatas::Elements
  def self.call
    super("ingredients")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row.delete("product_id"))
      puts "Création d'un nouvel ingerdient pour #{product.ref}"
      product.ingredients.create(cas:       row["CasNumber"],
                                 quantity:  row["RecipeQuantity"],
                                 product_identification: row["ProductIdentification"],
                                 file_name: row["Ingredients_file_name"],
                                 datas:     row)
    end
  end
end
