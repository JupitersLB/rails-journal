class Api::V1::ChatroomsController < ApplicationController
  def index
    chatrooms = policy_scope(Chatroom)
                .where(receiver: current_user).or(Chatroom.where(sender: current_user))
                .includes(:sender, :receiver)
                .map { |chatroom| [chatroom.id, chatroom.sender.username, chatroom.receiver.username, chatroom.messages.last] }
    chatrooms.map { |chat| chat.delete(current_user.username) }
    chatrooms.map! do |chat|
      friend = User.find_by_username(chat[1])
      {
        id: chat[0],
        user: current_user.username,
        friend: chat[1],
        photo: friend.photo.attached? ? Cloudinary::Utils.cloudinary_url(friend.photo.key) : ActionController::Base.helpers.asset_path("avatar.png"),
        last_seen: ApplicationController.helpers.time_ago_in_words(friend.last_seen_at),
        last_message: chat[2]
      }
    end
    chatrooms.sort_by! { |hsh| hsh[:last_message].created_at }.reverse!
    chatrooms.each { |chat| chat[:last_message] = { created_at: ApplicationController.helpers.time_ago_in_words(chat[:last_message].created_at), content: chat[:last_message].content } }
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
