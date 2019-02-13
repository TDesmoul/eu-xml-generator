class NokogiriXmlIngredient
  require 'nokogiri'

  def initialize(ingredient_name)
    file = File.open(Rails.root + "lib/xml_files/ingredients/#{ingredient_name}.xml")
    @xml = Nokogiri::XML(file).at("Ingredient")
  end

  def change_quantity(new_quantity)
    @xml.at("RecipeQuantity").content = new_quantity
    @xml
  end

  def self.call(ingredient_name, args = {})
    xml = self.new(ingredient_name)
    xml.change_quantity(args[:quantity]) if args[:quantity]
  end
end
