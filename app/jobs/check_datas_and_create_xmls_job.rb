class CheckDatasAndCreateXmlsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    message = "La vérification des ingrédients et des emissions est en cours..."
    ApplicationJob.broadcast_to_background_process_feedback(message)
    CheckIngredientsAndEmissions.call
    message = "La génération des XML cibles n'a pas été lancée à cause des CAS manquants."
    missing_ingredients = MissingXml.find_by(xml_type: "ingredient")
    missing_emissions = MissingXml.find_by(xml_type: "emission")
    missings = {}
    missings[:missing_ingredients] = missing_ingredients.elements if missing_ingredients
    missings[:missing_emissions] = missing_emissions.elements if missing_emissions
    ApplicationJob.broadcast_to_background_process_feedback(message, missings)

    unless MissingXml.count != 0
      message = "La génération des XML cibles est en cours..."
      ApplicationJob.broadcast_to_background_process_feedback(message)
      CreateTargetXmls.call
      message = "La génération des XML cibles est terminée."
      ApplicationJob.broadcast_to_background_process_feedback(message)
    end
  end

end
