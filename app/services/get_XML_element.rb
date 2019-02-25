class GetXMLElement
  require 'nokogiri'
  CATEGORIES = ["ingredient"]

  def self.call(category, args = {})
    element = self.retrieve(category, args)
    # TODO : ajouter l'update
  end

  def self.retrieve(category, args)
    names = self.element_names(category)
    file = File.open(Rails.root + "lib/xml_files/#{names[:repo]}/#{names[:name]}.xml")
    Nokogiri::XML(file).at(names[:node])
  end

  def self.update(element, category, args)
    update_ingredient(element, args) if category == "ingredient"
  end

  def self.update_ingredient(element, args)
    element.at("RecipeQuantity").content = args[:quantity] if args[:quantity]
  end

  private

  def self.element_names(category, args)
    case category
    when CATEGORIES[0]
      raise "Aucun nom d'ingredient n'a été donné." if args[:name].nil?
      repo = "ingredients"
      name = args[:name]
      node = "Ingredient"
    else
      raise "#{category} n'est pas une catégorie valide."
    end
    { repo: repo, node: node }
  end
end
