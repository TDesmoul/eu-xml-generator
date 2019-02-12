class NokogiriXmlBase
  require 'nokogiri'

  def initialize
    file = File.open(Rails.root + 'lib/xml_files/base.xml')
    @doc = Nokogiri::XML(file)
  end

  def add_element(parent, node_name, content)
    new_element = Nokogiri::XML::Node.new(node_name, @doc)
    new_element.content = content
    @doc.at(parent).add_child(new_element)
  end

  def write_xml(file_name)
    File.write(Rails.root + 'lib/xml_files/' + file_name, @doc.to_xml)
  end
end
