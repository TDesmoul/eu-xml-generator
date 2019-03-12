class XmlElement::AddAttribute
  def self.call(node, name, value)
    node.set_attribute(name, value)
    node
  end
end
