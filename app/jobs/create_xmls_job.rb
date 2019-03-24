class CreateXmlsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SaveCsvDatas::SaveAll.call
    missing_cas = []
    Product.all.each do |product|
      missing_cas.push(CreateEuXml.call(product))
    end
    puts "MISSING CAS => #{missing_cas.flatten.join(", ")}"
  end
end
