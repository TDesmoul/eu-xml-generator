class XmlBase::Retrieve
  def self.call(local_directory, file_name)
    # on download le fichier contenant l'element XML
    PfFtp.new.download_xml_base(local_directory, file_name)
    file_path = local_directory + file_name
    # on récupère le document XML
    xml_file = File.open(file_path)
    Nokogiri::XML(xml_file)
  end
end
