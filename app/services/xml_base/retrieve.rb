class XmlBase::Retrieve
  def self.call(product_id)
    # on download le fichier contenant l'element XML
    ftp_repo = "/source_xmls/"
    local_repo = "#{Rails.root}/lib/xml_files/"
    file = "base.xml"
    new_file_name = "#{product_id}.xml"
    PfFtp.new.download_xml_base(new_file_name)
    # on récupère l'element XML
    tag = "ECigProductFile"
    file_path = Rails.root + "lib/xml_files/#{new_file_name}"
    xml_file = File.open(file_path)
    Nokogiri::XML(xml_file).at(tag)
  end
end
