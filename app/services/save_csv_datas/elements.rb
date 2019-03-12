class SaveCsvDatas::Elements
  require 'csv'

  def self.call(elements)
    files = PfFtp.new.get_files_list(elements)     # on récupère la liste des fichiers dans le dossier sur le FTP
    files[:list].each do |file|                    # pour chaque nom de la liste, on télécharge le fichier
      PfFtp.new.download_file(files[:repo], "#{Rails.root}/lib/csv_files/#{elements}/", file)
    end
    csv_options = { col_sep: ';', headers: :first_row, encoding: "windows-1252:utf-8" }
    files[:list].each do |file|                    # pour chaque nom de la liste
      filepath = Rails.root + "lib/csv_files/#{elements}/" + file
      puts "traitement du fichier #{filepath}"
      CSV.foreach(filepath, csv_options) do |row|  # on ouvre le fichier et on traite les lignes
        self.process_row(row.to_h)
      end                                          # on supprime le fichier
      puts "Suppression du fichier téléchargé"
      FileUtils.rm_rf(Dir.glob("#{Rails.root}/lib/csv_files/#{elements}/#{file}"))
    end
  end
end
