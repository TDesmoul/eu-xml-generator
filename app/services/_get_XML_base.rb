class GetXMLBase
  require 'nokogiri'

  def self.call
    file = File.open(Rails.root + 'lib/xml_files/base.xml')
    Nokogiri::XML(file)
  end
end
