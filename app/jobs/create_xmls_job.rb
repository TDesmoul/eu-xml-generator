class CreateXmlsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Product.order(:id).each do |product|
      puts '#############################'
      puts "taking care of #{product.ref}"
      CreateEuXml.call(product)
    end
  end
end
