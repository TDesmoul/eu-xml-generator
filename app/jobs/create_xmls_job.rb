class CreateXmlsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SaveCsvDatas::SaveAll.call
    missing_cas = []
    Product.order(:id).each do |product|
      puts '#############################'
      puts "taking care of #{product.ref}"
      missing_cas.push(CreateEuXml.call(product))
    end
    puts "MISSING CAS => #{missing_cas.flatten.join(", ")}"
  end
end
