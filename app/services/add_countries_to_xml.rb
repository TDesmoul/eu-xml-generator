class AddCountriesToXml
  def self.call(file_name, countries)
    # on récupère le fichier xml source
    local_dir = Rails.root + "lib/xml_files/"
    PfFtp.new.download_file("add_countries/source_xmls", local_dir, file_name)
    file_path = local_dir + file_name
    xml_file = File.open(file_path)
    xml_doc = Nokogiri::XML(xml_file)

    # on récupère la liste des pays manquant dans le fichier
    countries_in_file = xml_doc.xpath("//Presentation").map{|p| p.at("NationalMarket").text }
    missing_countries = countries - countries_in_file
    # on récupère le 1er bloc pays de xml_doc
    xml_element = xml_doc.at("Presentation")
    # on ajoute les pays manquant dans xml_doc
    missing_countries.each do |country_code|
      #   on clone la base
      new_country = xml_element.clone
      #   on modifie le nom du pays
      new_country.at("NationalMarket").content = country_code
      #   on insère dans xml_doc
      xml_doc.at("//Presentations").add_child(new_country)
    end

    # on enregistre le fichier
    self.write_xml(file_path, xml_doc)
    # on upload le fichier sur le FTP
    PfFtp.new.upload_file("#{"test/" if Rails.env.development? }add_countries/updated_xmls", file_path)
    # on supprime le fichier local
    FileUtils.rm_rf(Dir.glob(file_path))
  end

  def self.write_xml(file_path, xml_doc)
    puts "Sauvegarde du XML en local..."
    File.write(file_path, xml_doc.to_xml)
  end
end
