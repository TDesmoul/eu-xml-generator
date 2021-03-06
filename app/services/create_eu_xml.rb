class CreateEuXml
  def self.call(product)
    # on récupère la base XML dans un nouveau fichier
    local_dir = Rails.root + "lib/xml_files/"
    file_name = "#{product.uuid}.xml"
    file_path = local_dir + file_name
    # file_path = Rails.root + "lib/xml_files/#{product.uuid}.xml"
    base = XmlBase::Retrieve.call(local_dir, file_name)

    # on met à jour les éléments de niveau 1
    product.datas.each do |tag, value|
      base.at(tag).content = value
    end
    base.at("NicotineDoseUptakeFile").set_attribute("attachmentID",
      product.nicotine_dose_uptake_file)
    base.at("ConsistentDosingMethodsFile").set_attribute("attachmentID",
      product.consistent_dosing_methods_file)
    self.write_xml(file_path, base)

    # # on ajoute le manufacturer
    # manufacturer = XmlElement::Retrieve.call(:manufacturer,
    #   file: "#{product.manufacturer_file_name}.xml")
    # base.at("Manufacturers").add_child(manufacturer)
    # self.write_xml(file_path, base)

    # on récupère 'presentation'
    presentation = XmlElement::Retrieve.call(:presentation,
      file: "#{product.presentation_file_name}")
    # on update les infos de base
    product.presentation.datas.each do |tag, value|
      presentation.at(tag).content = value
    end
    # on duplique pour chaque pays, et on ajoute à la base
    product.countries.each do |country|
      new_presentation = presentation.clone
      new_presentation.at("NationalMarket").content = country.code
      base.at("Presentations").add_child(new_presentation)
    end
    self.write_xml(file_path, base)

    # on ajoute les ingredients
    missing_ingredients = []
    product.ingredients.each do |ingredient|
      xml_ingredient = XmlIngredient::Retrieve.call(ingredient.file_name, ingredient.cas)
      if xml_ingredient
        xml_ingredient.at("RecipeQuantity").content = ingredient.quantity
        base.at("Ingredients").add_child(xml_ingredient)
      else
        missing_ingredients.push(ingredient.cas)
      end
    end
    self.write_xml(file_path, base)

    # on ajoute les emissions
    product.emissions.each do |emission|
      xml_emission = XmlEmission::Retrieve.call(emission.file_name, emission.cas)
      xml_emission.at("Quantity").content = emission.quantity
      xml_emission.at("ProductIdentification").content = emission.product_identification
      xml_emission.at("Attachment").set_attribute("attachmentID",
        product.nicotine_dose_uptake_file)
      base.at("Emissions").add_child(xml_emission)
    end
    self.write_xml(file_path, base)

    # # on ajoute le design
    # design = XmlElement::Retrieve.call(:design,
    #   file: "#{product.design_file_name}.xml")
    # # on update les infos de base
    # product.design.datas.each do |tag, value|
    #   design.at(tag).content = value
    # end
    # base.at("Design").replace(design)
    # self.write_xml(file_path, base)

    # on upload le fichier sur le FTP
    PfFtp.new.upload_file("#{"test/" if Rails.env.development? }target_xmls", file_path)
    missing_ingredients
  end

  def self.write_xml(file_path, xml_doc)
    File.write(file_path, xml_doc.to_xml)
  end
end
