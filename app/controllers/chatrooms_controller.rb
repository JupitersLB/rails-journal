class ChatroomsController < ApplicationController
  def index
    @chatrooms = policy_scope(Chatroom).find_user_chatrooms(current_user)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
    authorize @message
  end
end
