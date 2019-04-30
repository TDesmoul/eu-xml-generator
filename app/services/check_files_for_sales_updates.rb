class CheckFilesForSalesUpdates
  def self.call
    csv_files_ids = AnnualSale.pluck(:file_id).uniq.map{ |file_id| file_id + ".xml" }
    ftp_files_ids = PfFtp.new.get_annual_sales_source_files_list
    { csv: csv_files_ids, ftp: ftp_files_ids }
    missing_on_ftp = csv_files_ids - ftp_files_ids
    absent_in_csv = ftp_files_ids - csv_files_ids
    if missing_on_ftp.present?
      puts "Les fichiers suivants n'ont pas été trouvés sur le FTP : #{missing_on_ftp.join(", ")}"
    elsif absent_in_csv.present?
      puts "Les fichiers suivants ne sont pas mentionnés dans le CSV : #{absent_in_csv.join(", ")}"
    else
      puts "Tous les fichiers sont là."
    end
  end
end
