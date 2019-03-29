class CreateTargetXmls
  def self.call
    Product.order(:id).each do |product|
      puts "taking care of #{product.ref}"
      message = "Génération du fichier pour le produit #{product.ref}..."
      ApplicationJob.broadcast_to_background_process_feedback(message)
      CreateEuXml.call(product)
    end
  end
end
