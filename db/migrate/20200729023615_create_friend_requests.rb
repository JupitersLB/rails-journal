class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.belongs_to :requestor
      t.belongs_to :receiver

      t.timestamps
    end
  end
end
