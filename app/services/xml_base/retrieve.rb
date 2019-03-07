class XmlBase::Retrieve
  def self.call(file_path)
    # on download le fichier contenant l'element XML
    PfFtp.new.download_xml_base(file_path)
    # on récupère le document XML
    xml_file = File.open(file_path)
    Nokogiri::XML(xml_file)
  end
end
