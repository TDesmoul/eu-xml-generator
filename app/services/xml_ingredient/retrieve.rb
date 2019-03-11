class XmlIngredient::Retrieve
  def self.call(file_name, cas_number)
    file_path = Rails.root + "lib/banque_ingredient_1.xml" # "lib/#{file_name}"
    xml_file = File.open(file_path)
    xml_doc = Nokogiri::XML(xml_file)
    xml_doc.xpath("//CasNumber[text()='#{cas_number}']").first
  end
end
