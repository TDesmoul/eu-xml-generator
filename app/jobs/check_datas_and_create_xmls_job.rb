class CheckDatasAndCreateXmlsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "destroying all MissingXml..."
    MissingXml.destroy_all
    puts "Saving csvs datas in DB..."
    SaveCsvDatas::SaveAll.call
    puts "Saving ingredients and emissions locations..."
    SaveIngredients::InDb.call
    SaveEmissions::InDb.call
    puts "Checking for missing ingredient or emission..."
    missing = Ingredient.pluck(:cas) - IngredientLocation.pluck(:cas)
    MissingXml.create(xml_type: "ingredient", elements: missing) unless missing.blank?
    missing = Emission.pluck(:cas) - EmissionLocation.pluck(:cas)
    MissingXml.create(xml_type: "emission", elements: missing) unless missing.blank?
    puts "#{MissingXml.count} élement(s) manquant."
    unless MissingXml.count != 0
      Product.order(:id).each do |product|
        puts "taking care of #{product.ref}"
        CreateEuXml.call(product)
      end
    end
  end

end
