class SaveInDb::Emissions
  require 'csv'

  def self.call
    # on récupère la liste des fichiers dans le dossier sur le FTP
    files = PfFtp.new.get_files_list("emissions")
    # pour chaque nom de la liste, on télécharge le fichier
    files[:list].each do |file|
      PfFtp.new.download_file(files[:repo], "#{Rails.root}/lib/csv_files/emissions/", file)
    end
    # pour chaque nom de la liste
    csv_options = { col_sep: ';', headers: :first_row, encoding: "windows-1252:utf-8" }
    files[:list].each do |file|
      filepath = Rails.root + "lib/csv_files/emissions/" + file
      # on ouvre le fichier
      CSV.foreach(filepath, csv_options) do |row|
        # on update le produit s'il existe
        if product = Product.find_by(ref: row["product_id"])
          product.emissions.create(
            cas: row["CasNumber"],
            quantity: row["RecipeQuantity"]
          )
        end
      end
      # on supprime le fichier
      FileUtils.rm_rf(Dir.glob("#{Rails.root}/lib/csv_files/emissions/#{file}"))
    end
  end
end
