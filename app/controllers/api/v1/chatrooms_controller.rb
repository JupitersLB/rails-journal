class Api::V1::ChatroomsController < ApplicationController
  def index
    chatrooms = policy_scope(Chatroom)
                .where(receiver: current_user).or(Chatroom.where(sender: current_user))
                .includes(:sender, :receiver)
                .map { |chatroom| [chatroom.id, chatroom.sender.username, chatroom.receiver.username] }
    chatrooms.map { |chat| chat.delete(current_user.username) }
    chatrooms.map! { |chat| { id: chat[0], friend: chat[1] } }
    render json: chatrooms
  end

  def show
    chatroom = Chatroom.find(params[:id])
    messages = chatroom.messages
    message = Message.new

    render json: [messages]
    authorize chatroom
    authorize message
    authorize messages
  end
end
