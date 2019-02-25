class SaveInDb::ProductDatas
  require 'csv'

  def self.call
    # on récupère la liste des fichiers dans le dossier sur le FTP
    files = PfFtp.new.get_files_list("product_datas")
    # pour chaque nom de la liste, on télécharge le fichier
    files[:list].each do |file|
      puts "FILE IS #{file}"
      PfFtp.new.download_file(files[:repo], "#{Rails.root}/lib/csv_files/product_datas/", file)
    end
    # pour chaque nom de la liste
    csv_options = { col_sep: ';', headers: :first_row, encoding: "windows-1252:utf-8" }
    files[:list].each do |file|
      filepath = Rails.root + "lib/csv_files/product_datas/" + file
      # on ouvre le fichier
      CSV.foreach(filepath, csv_options) do |row|
        # on update le produit s'il existe
        if product = Product.find_by(ref: row["product_id"])
          product.update!(datas: row.delete_if{ |k, v| k == "product_id"})
        # on créé un nouveau produit s'il n'existe pas
        else
          Product.create!(
            ref: row["product_id"],
            datas: row.delete_if{ |k, v| k == "product_id" }
          )
        end
      end
      # on supprime le fichier
      FileUtils.rm_rf(Dir.glob("#{Rails.root}/lib/csv_files/product_datas/#{file}"))
    end
  end
end
