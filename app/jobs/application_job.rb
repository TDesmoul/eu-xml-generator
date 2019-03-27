class ApplicationJob < ActiveJob::Base
  def self.broadcast_to_background_process_for_user(message)
    ActionCable.server.broadcast("background_process_for_#{args[:user]}", {
      message: message
    })
  end
end
