class SaveCsvDatas::Emissions < SaveCsvDatas::Elements
  def self.call
    super("emissions")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row["product_id"])
      puts "Création d'une nouvelle emission pour #{product.ref}"
      product.emissions.create(cas:       row["CasNumber"],
                               quantity:  row["RecipeQuantity"],
                               product_identification: row["ProductIdentification"],
                               file_name: row["Emissions_file_name"])
    end
  end
end
