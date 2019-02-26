class XmlElement::Update
  def self.call(element, record)
    record.datas.each do |tag, value|
      element.at(tag).content = value
    end
    element
  end
end
