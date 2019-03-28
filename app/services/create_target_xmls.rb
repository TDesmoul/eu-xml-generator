class CreateTargetXmls
  def self.call
    Product.order(:id).each do |product|
      puts "taking care of #{product.ref}"
      CreateEuXml.call(product)
    end
  end
end
