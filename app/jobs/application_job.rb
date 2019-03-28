class ApplicationJob < ActiveJob::Base
  def self.broadcast_to_background_process_feedback(message, args = {})
    ActionCable.server.broadcast("background_process_feedback", {
      message: message,
      missing_ingredients: args[:missing_ingredients],
      missing_emissions: args[:missing_emissions]
    })
  end
end
