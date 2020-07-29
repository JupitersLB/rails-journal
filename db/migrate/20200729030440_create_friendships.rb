class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :friend_a
      t.belongs_to :friend_b

      t.timestamps
    end
  end
end
