class SaveCsvDatas::AnnualSales < SaveCsvDatas::Elements
  def self.call
    puts "Suppression des AnnualSales existants."
    AnnualSale.destroy_all
    super("sales_updates")
  end

  def self.process_row(row)
    file_id = row.delete("file_id")
    year = row.delete("year").to_f
    puts "Création des AnnualSales pour le fichier #{file_id}..."
    row.each do |country, sales|
      AnnualSale.create(
        file_id: file_id,
        year: year,
        country: country,
        sales: sales.blank? ? nil : sales
      )
    end
  end
end
