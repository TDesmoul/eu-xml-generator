class SaveCsvDatas::Emissions < SaveCsvDatas::Elements
  def self.call
    super("emissions")
  end

  def self.process_row(row)
    if product = Product.find_by(ref: row["product_id"])
      puts "Création d'une nouvelle emission pour #{product.ref}"
      product.emissions.create(
        cas:       row["CasNumber"],
        quantity:  row["Quantity"],
        product_identification: row["ProductIdentification"],
        file_name: EmissionLocation.find_by(cas: row["CasNumber"]).file
      )
    end
  end
end
