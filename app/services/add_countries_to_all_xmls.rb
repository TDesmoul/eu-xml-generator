class AddCountriesToAllXmls
  def self.call(countries = [])
    # on récupère la liste des xmls présents dans sales_updates/source_xmls (FTP)
    ftp_files = PfFtp.new.get_add_countries_source_files_list

    ftp_files.each do |file|
      AddCountriesToXml.call(file, countries)
    end

    message = "L'ajout des pays est terminée."
    ApplicationJob.broadcast_to_background_process_feedback(message)
  end
end
