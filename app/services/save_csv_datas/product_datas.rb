class SaveCsvDatas::ProductDatas < SaveCsvDatas::Elements
  def self.call
    super("product_datas")
  end

  def self.process_row(row)
    product = Product.find_by(ref: row["product_id"]) || Product.new
    # product.submitter_file_name = row.delete("submitter_file_name")
    # product.manufacturer_file_name = row.delete("manufacturer_file_name")
    product.presentation_file_name = row.delete("presentation_file_name")
    product.design_file_name = row.delete("design_file_name")
    product.ref = row.delete("product_id")
    product.uuid = row["uuid"]
    product.nicotine_dose_uptake_file = row.delete("NicotineDoseUptakeFile")
    product.consistent_dosing_methods_file = row.delete("ConsistentDosingMethodsFile")
    product.datas = row.select{ |k,v| self.product_data?(k) }
    product.save!
    Presentation.create!(
      product: product,
      datas: row.select{ |k,v| self.presentation_data?(k) }
    )
    # Design.create!(
    #   product: product,
    #   datas: row.select{ |k,v| self.design_data?(k) }
    # )
  end

  def self.product_data?(k) # liste des colonnes du noeud "Product"
    ["ProductID", "uuid", "Weight", "ClpClassification", "Description",
      "NicotineConcentration"].include?(k)
  end

  def self.presentation_data?(k) # liste des colonnes du noeud "Presentation"
    ["BrandName", "BrandSubtypeName", "LaunchDate", "ProductNumber", "Year"].include?(k)
  end

  # def self.design_data?(k) # liste des colonnes du noeud "Design"
  #   ["Description", "NicotineConcentration", "NicotineDoseUptakeFile"].include?(k)
  # end
end
