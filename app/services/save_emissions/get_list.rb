class SaveEmissions::GetList
  def self.call
    list = PfFtp.new.get_emissions_files_list
    emissions = {}
    list.each do |file|
    # file = list.first
      ftp_repo = "/source_xmls/emissions"
      local_repo = "#{Rails.root}/lib/xml_files/"
      PfFtp.new.download_file(ftp_repo, local_repo, file)
      file_path = local_repo + file
      xml_file = File.open(file_path)
      xml_doc = Nokogiri::XML(xml_file)
      emissions[file] = xml_doc.css("Emission > CasNumber").map{ |el| el.content }
    end
    emissions
  end
end
