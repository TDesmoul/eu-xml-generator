class XmlElement::Retrieve < XmlElement::RetrieveFromFtp
  def self.call(element_type, args = {})
    self.check_if_element_type_is_valid(element_type)
    # on download le fichier contenant l'element XML
    ftp_repo = "/source_xmls/#{TYPES[element_type][:repo]}"
    local_repo = "#{Rails.root}/lib/xml_files/"
    file = self.set_file(element_type, args)
    PfFtp.new.download_file(ftp_repo, local_repo, file)
    # on récupère l'element XML
    tag = self.set_tag(element_type, args)
    file_path = Rails.root + "lib/xml_files/#{file}"
    xml_file = File.open(file_path)
    xml_element = Nokogiri::XML(xml_file).at(tag)
    # on supprime le fichier téléchargé
    FileUtils.rm_rf(Dir.glob(file_path))
    return xml_element
  end

  private

  def self.set_tag(element_type, args = {})
    args[:tag] || TYPES[element_type][:tag]
  end

  def self.set_file(element_type, args = {})
    if args[:file].nil? && TYPES[element_type][:default_file].nil?
      raise ArgumentError.new("You must provide a file name for this type of element")
    else
      return args[:file] || args[:file_name] || TYPES[element_type][:default_file]
    end
  end

  def self.check_if_element_type_is_valid(element_type)
    unless element_type.is_a?(Symbol)
      message = "#{element_type} must be a Symbol"
      raise ArgumentError.new(message)
    end
    unless TYPES.keys.include?(element_type)
      list = TYPES.keys.join(", ")
      message = "#{element_type} doesn't belong to types list (#{list})"
      raise ArgumentError.new(message)
    end
  end
end
