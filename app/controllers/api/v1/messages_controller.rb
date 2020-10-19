class Api::V1::MessagesController < ApplicationController
  before_action :set_chatroom

  # def create
  #   chatroom = Chatroom.find(params[:chatroom_id])
  #   message = Message.new(message_params)
  #   message.chatroom = chatroom
  #   message.user = current_user
  #   if message.save
  #     ChatroomChannel.broadcast_to(
  #       chatroom,
  #       render_to_string(partial: "message", locals: { message: @message })
  #     )
  #     render json: chatrooms
  #   else
  #     render "chatrooms/show"
  #   end
  # end

  def create
    message = @chatroom.messages.build(content: params[:content])
    message.user = current_user
    message.save
    authorize message
    render json: message # see Message.as_json method
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  # def message_params
  #   params.require(:message).permit(:content)
  # end
end
