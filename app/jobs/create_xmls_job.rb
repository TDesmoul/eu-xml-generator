class CreateXmlsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SaveCsvDatas::SaveAll.call
    Product.all.each do |product|
      CreateEuXml.call(product)
    end
  end
end
