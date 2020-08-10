class AddAcceptedToFriendRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :friend_requests, :accepted, :boolean, default: false
  end
end
