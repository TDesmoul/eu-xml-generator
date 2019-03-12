class SaveCsvDatas::SaveAll
  def self.call
    Product.destroy_all
    SaveCsvDatas::ProductDatas.call
    SaveCsvDatas::Countries.call
    SaveCsvDatas::Ingredients.call
    SaveCsvDatas::Emissions.call
  end
end
