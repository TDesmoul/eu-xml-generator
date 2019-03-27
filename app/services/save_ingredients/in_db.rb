class SaveIngredients::InDb
  def self.call
    SaveIngredients::GetList.call.each do |file, cas_numbers|
      cas_numbers.each do |cas|
        if location = IngredientLocation.find_by(cas: cas)
          location.update(file: file) if location.file != file
        else
          IngredientLocation.create(cas: cas, file: file)
        end
      end
    end
  end
end
