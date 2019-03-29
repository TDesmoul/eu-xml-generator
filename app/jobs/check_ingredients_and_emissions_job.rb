class CheckIngredientsAndEmissionsJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    message = "La vérification des ingrédients et des emissions est en cours..."
    ApplicationJob.broadcast_to_background_process_feedback(message)
    CheckIngredientsAndEmissions.call
    message = "La vérification des ingrédients et des emissions est terminée."
    missing_ingredients = MissingXml.find_by(xml_type: "ingredient")
    missing_emissions = MissingXml.find_by(xml_type: "emission")
    missings = {}
    missings[:missing_ingredients] = missing_ingredients.elements if missing_ingredients
    missings[:missing_emissions] = missing_emissions.elements if missing_emissions
    ApplicationJob.broadcast_to_background_process_feedback(message, missings)
    rescue
      message = "Une erreur est survenue: la vérification est suspendue."
      ApplicationJob.broadcast_to_background_process_feedback(message)
  end
end
