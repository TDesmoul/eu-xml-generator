class XmlElement::RetrieveFromFtp
  require 'nokogiri'

  TYPES = {
    design: { repo: "designs", tag: "Design", default_file: "design-01.xml" },
    emission: { repo: "emissions", tag: "Emission" },
    ingredient: { repo: "ingredients", tag: "Ingredient" },
    manufacturer: { repo: "manufacturers", tag: "Manufacturer", default_file: "lab-rome.xml" },
    presentation: { repo: "presentations", tag: "Presentation", default_file: "presentation-01.xml" },
    submitter: { repo: "submitters", tag: "Submitter", default_file: "submitter-01.xml" },
    other: { repo: "others" }
  }
end
