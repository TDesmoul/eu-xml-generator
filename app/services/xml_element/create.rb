class XmlElement::Create
  def self.call(document, node_name, content, attributes_array = nil)
    new_node = Nokogiri::XML::Node.new(node_name, document)
    new_node.content = content
    if attributes_array
      attributes_array.each do |attribute|
        XmlElement::AddAttribute.call(new_node, attribute[0], attribute[1])
      end
    end
  end
end
