class AnnualSale < ApplicationRecord
  def self.xml_files_list_with_extension
    pluck(:file_id).uniq.map{ |file_id| file_id + ".xml" }
  end
  def self.xml_file_ids_list
    pluck(:file_id).uniq
  end
end
