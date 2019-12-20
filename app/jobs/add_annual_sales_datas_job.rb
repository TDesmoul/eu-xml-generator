class AddAnnualSalesDatasJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    message = "L'ajout des AnnualSalesDatas est en cours..."
    ApplicationJob.broadcast_to_background_process_feedback(message)
    feedback = UpdateAllXmlsWithSales.call
    message = "L'ajout des AnnualSalesDatas est terminée."
    feedback_message = {}
    feedback_message[:missing_on_ftp] = feedback.missing_on_ftp
    feedback_message[:absent_in_csv] = feedback.absent_in_csv
    feedback_message[:missing_countries] = feedback.missing_countries
    ApplicationJob.broadcast_to_background_process_feedback(message, feedback_message)
  rescue
    message = "Une erreur est survenue: la vérification est suspendue."
    ApplicationJob.broadcast_to_background_process_feedback(message)
  end
end
