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
    messages = policy_scope(Message)
               .where(chatroom: params[:id])
               .includes(:user)
               .map do |m|
                 {
                   id: m.id,
                   content: m.content,
                   chatroom: m.chatroom_id,
                   username: m.user.username,
                   created_at: m.created_at
                 }
               end
    message = Message.new

    render json: [messages]
    authorize message
  end
end
