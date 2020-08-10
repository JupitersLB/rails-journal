class Friendship < ApplicationRecord
  belongs_to :friend_a, class_name: :User
  belongs_to :friend_b, class_name: :User
  validate :users_are_not_already_friends

  def users_are_not_already_friends
    if Friendship.where(friend_a_id: friend_b.id, friend_b_id: friend_a.id).exists? ||
       Friendship.where(friend_a_id: friend_a.id, friend_b_id: friend_b.id).exists?
      errors.add(:friend_a_id, 'Already friends!')
    end
  end
end
