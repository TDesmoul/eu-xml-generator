class SaveEmissions::InDb
  def self.call
    SaveEmissions::GetList.call.each do |file, cas_numbers|
      cas_numbers.each do |cas|
        if location = EmissionLocation.find_by(cas: cas)
          location.update(file: file) if location.file != file
        else
          EmissionLocation.create(cas: cas, file: file)
        end
      end
    end
  end
end
