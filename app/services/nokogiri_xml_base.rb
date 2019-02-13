class NokogiriXmlBase
  require 'nokogiri'

  def initialize
    file = File.open(Rails.root + 'lib/xml_files/base.xml')
    @doc = Nokogiri::XML(file)
  end

  def insert_xml_element(parent, element)
    @doc.at(parent).add_child(element)
  end

  def create_xml_node(node_name, content)
    Nokogiri::XML::Node.new(node_name, @doc)
    new_element.content = content
  end

  def write_xml(file_name)
    File.write(Rails.root + 'lib/xml_files/' + file_name, @doc.to_xml)
  end
end
