class UpdateAllXmlsWithSales
  def self.call
    AnnualSalesUpdateFeedback.destroy_all
    SaveCsvDatas::AnnualSales.call
    feedback = AnnualSalesUpdateFeedback.new(CheckFilesForSalesUpdates.call)
    # on récupère le bloc AnnualSalesData que l'on garde sous le coude (1)
    annual_sales_xml_base = XmlElement::Retrieve.call(:annual_sales)
    # on récupère la listes des files_ids des AnnualSales et on boucle sur la liste
    files_ids = AnnualSale.pluck(:file_id).uniq
    missing_countries = {}
    files_ids.each do |file_id|
      missing_countries[file_id] = UpdateXmlWithSales.call(file_id, annual_sales_xml_base)
    end
    feedback.missing_countries = missing_countries
    feedback.save
    feedback
  end
end
