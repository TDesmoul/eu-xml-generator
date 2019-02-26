class SaveInDb::SaveAll
  def self.call
    SaveInDb::ProductDatas.call
    SaveInDb::Countries.call
    SaveInDb::Ingredients.call
    SaveInDb::Emissions.call
  end
end
