class XmlIngredient::Retrieve
  def self.call(file_name, cas_number)
    # download file from FTP :
    ftp_repo = "/source_xmls/ingredients"
    local_repo = "#{Rails.root}/lib/xml_files/"
    PfFtp.new.download_file(ftp_repo, local_repo, file_name)
    # retrieve xml ingredient with cas_number :
    file_path = Rails.root + "lib/xml_files/#{file_name}"
    xml_file = File.open(file_path)
    xml_doc = Nokogiri::XML(xml_file)
    xml_doc.xpath("//Ingredient//CasNumber[text()='#{cas_number}']").first.parent
  end
end
