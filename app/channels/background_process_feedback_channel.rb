class BackgroundProcessFeedbackChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "background_process_for_#{params[:user]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
