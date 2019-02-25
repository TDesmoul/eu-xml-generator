class SaveInDb::Countries
  require 'csv'

  def self.call
    # on récupère la liste des fichiers dans le dossier sur le FTP
    files = PfFtp.new.get_files_list("countries")
    # pour chaque nom de la liste, on télécharge le fichier
    files[:list].each do |file|
      PfFtp.new.download_file(files[:repo], "#{Rails.root}/lib/csv_files/countries/", file)
    end
    # pour chaque nom de la liste
    csv_options = { col_sep: ';', headers: :first_row, encoding: "windows-1252:utf-8" }
    files[:list].each do |file|
      filepath = Rails.root + "lib/csv_files/countries/" + file
      # on ouvre le fichier
      CSV.foreach(filepath, csv_options) do |row|
        # on update le produit s'il existe
        if product = Product.find_by(ref: row["product_id"])
          product.countries.create(code: row["NationalMarket"])
        end
      end
      # on supprime le fichier
      FileUtils.rm_rf(Dir.glob("#{Rails.root}/lib/csv_files/countries/#{file}"))
    end
  end
end
