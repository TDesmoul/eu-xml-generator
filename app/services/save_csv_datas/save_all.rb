class SaveCsvDatas::SaveAll
  def self.call
    SaveCsvDatas::ProductDatas.call
    SaveCsvDatas::Countries.call
    SaveCsvDatas::Ingredients.call
    SaveCsvDatas::Emissions.call
  end
end
