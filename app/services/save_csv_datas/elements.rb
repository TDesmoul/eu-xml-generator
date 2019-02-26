class SaveCsvDatas::Elements
  require 'csv'

  def self.call(elements)
    # on récupère la liste des fichiers dans le dossier sur le FTP
    files = PfFtp.new.get_files_list(elements)
    # pour chaque nom de la liste, on télécharge le fichier
    files[:list].each do |file|
      PfFtp.new.download_file(files[:repo], "#{Rails.root}/lib/csv_files/#{elements}/", file)
    end
    # pour chaque nom de la liste
    csv_options = { col_sep: ';', headers: :first_row, encoding: "windows-1252:utf-8" }
    files[:list].each do |file|
      filepath = Rails.root + "lib/csv_files/#{elements}/" + file
      # on ouvre le fichier
      CSV.foreach(filepath, csv_options) do |row|
        self.process_row(row.to_h)
      end
      # on supprime le fichier
      FileUtils.rm_rf(Dir.glob("#{Rails.root}/lib/csv_files/#{elements}/#{file}"))
    end
  end
end
