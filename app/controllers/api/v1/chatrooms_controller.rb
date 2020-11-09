class Api::V1::ChatroomsController < ApplicationController
  def index
    @chatrooms = policy_scope(Chatroom)
                 .where(receiver: current_user).or(Chatroom.where(sender: current_user))
                 .includes(:sender, :receiver)
  end

  def show
    @messages = policy_scope(Message)
                .where(chatroom: params[:id])
                .includes(:user)
    message = Message.new
    authorize message
  end
end
