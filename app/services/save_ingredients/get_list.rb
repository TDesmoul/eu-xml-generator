class SaveIngredients::GetList
  def self.call
    list = PfFtp.new.get_ingredients_files_list
    ingredients = {}
    list.each do |file|
    # file = list.first
      ftp_repo = "/source_xmls/ingredients"
      local_repo = "#{Rails.root}/lib/xml_files/"
      PfFtp.new.download_file(ftp_repo, local_repo, file)
      file_path = local_repo + file
      xml_file = File.open(file_path)
      xml_doc = Nokogiri::XML(xml_file)
      ingredients[file] = xml_doc.css("Ingredient > CasNumber").map{ |el| el.content }
    end
    ingredients
  end
end
