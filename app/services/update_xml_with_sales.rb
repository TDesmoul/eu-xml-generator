class UpdateXmlWithSales
  def self.call(file_id, annual_sales_xml_base)
    file = file_id + ".xml"
    # on récupère le fichier xml source
    local_dir = Rails.root + "lib/xml_files/"
    PfFtp.new.download_file("sales_updates/source_xmls", local_dir, file)
    file_path = local_dir + file
    xml_file = File.open(file_path)
    xml_doc = Nokogiri::XML(xml_file)
    # on récupère tous les AnnualSales associés au fichier, et on boucle dessus
    missing_countries = []
    AnnualSale.where(file_id: file_id).where.not(sales: nil).each do |annual_sales|
      puts "On créé le bloc AnnualSalesData pour le pays #{annual_sales.country}..."
      # on clone le bloc (1) et on le modifie avec les valeurs de l'AnnualSales
      annual_sales_xml = annual_sales_xml_base.clone
      annual_sales_xml.at("Year").content = annual_sales.year.to_s + "+00:00"
      annual_sales_xml.at("SalesVolume").content = annual_sales.sales
      puts annual_sales_xml
      # on trouve le bloc Presentation correspondant au pays
      if xml_doc.xpath("//Presentation//NationalMarket[text()='#{annual_sales.country}']").empty?
        missing_countries << annual_sales.country
      else
        presentation = xml_doc.xpath("//Presentation//NationalMarket[text()='#{annual_sales.country}']").first.parent
        # on insère le bloc annual_sales
        presentation.at("AnnualSalesDataList").add_child(annual_sales_xml)
      end
    end
    sales_year = AnnualSale.where(file_id: file_id).last.year
    # On complète les présentations pour lesquelles on a pas d'AnnualSale
    # en ajoutant un bloc AnnualSalesData avec un CA à 0
    puts "On créé les blocs AnnualSalesData pour les pays pour lesquels on a pas de données sur #{sales_year}..."
    xml_doc.root.css("Presentation").each do |presentation|
      include_2018 = presentation.css("AnnualSalesData Year").map{ |year| year.text.strip.include?("2018")}.include?(true)
      unless include_2018
        annual_sales_xml = annual_sales_xml_base.clone
        annual_sales_xml.at("Year").content = "2018+00:00"
        annual_sales_xml.at("SalesVolume").content = "0"
        presentation.at("AnnualSalesDataList").add_child(annual_sales_xml)
      end
    end
    puts "Tous les blocs AnnualSalesData ont été créés et ajoutés!"
    # on enregistre le fichier
    self.write_xml(file_path, xml_doc)
    # on upload le fichier sur le FTP
    PfFtp.new.upload_file("#{"test/" if Rails.env.development? }sales_updates/updated_xmls", file_path)
    # on supprime le fichier local
    FileUtils.rm_rf(Dir.glob(file_path))
    return missing_countries
  rescue
    ["Problème sur ce fichier : #{file_id}.xml..."]
  end

  def self.write_xml(file_path, xml_doc)
    puts "Sauvegarde du XML en local..."
    File.write(file_path, xml_doc.to_xml)
  end
end
