json.array! @chatrooms do |chatroom|
  friend_name = chatroom.sender.username == current_user.username ? chatroom.receiver.username : chatroom.sender.username
  friend = User.find_by_username(friend_name)
  message = chatroom.messages.last
  json.id chatroom.id
  json.user current_user.username
  json.friend friend_name
  json.photo friend.photo.attached? ? cloudinary_url(friend.photo.key) : asset_path("avatar.png")
  json.last_seen time_ago_in_words(friend.last_seen_at)
  if message
    json.last_message do
      json.created_at time_ago_in_words message.created_at
      json.content message.content
    end
  end
end
