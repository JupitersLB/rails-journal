class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "channel_#{params[:name]}"
  end
end
