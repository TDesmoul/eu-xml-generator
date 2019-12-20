class AddCountriesToXmlsJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    message = "L'ajout des pays est en cours..."
    ApplicationJob.broadcast_to_background_process_feedback(message)
    AddCountriesToAllXmls.call(args[:countries])
    message = "L'ajout des pays est terminée."
  rescue
    message = "Une erreur est survenue..."
    ApplicationJob.broadcast_to_background_process_feedback(message)
  end
end
