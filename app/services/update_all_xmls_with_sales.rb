class UpdateAllXmlsWithSales
  def self.call
    # on supprime les feedbacks des batchs de mise à jour précédent
    AnnualSalesUpdateFeedback.destroy_all
    # on enregistre les AnnualSales à partir du csv
    SaveCsvDatas::AnnualSales.call
    # on sauvegarde le feedback pour ce batch de fichiers
    feedback = AnnualSalesUpdateFeedback.new(CheckFilesForSalesUpdates.call)
    # on récupère le bloc AnnualSalesData que l'on garde sous le coude (coquille vide)
    annual_sales_xml_base = XmlElement::Retrieve.call(:annual_sales)
    # on récupère la listes des files_ids des AnnualSales et on boucle sur la liste
    files_ids = AnnualSale.xml_file_ids_list
    missing_countries = {}
    files_ids.each do |file_id|
      missing_countries[file_id] = UpdateXmlWithSales.call(file_id, annual_sales_xml_base)
    end
    feedback.missing_countries = missing_countries
    feedback.save
    feedback
  end
end
