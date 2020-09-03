class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: :User
  belongs_to :receiver, class_name: :User

  validate :unique_chatrooms

  def unique_chatrooms
    if Chatroom.where(sender: receiver, receiver: sender).exists? ||
       Chatroom.where(sender: sender, receiver: receiver).exists?
      errors.add(:sender, 'Already have chatroom!')
    end
  end

  def self.find_user_chatrooms(user)
    if Chatroom.where(sender: user).exists?
      Chatroom.where(sender: user)
    elsif Chatroom.where(receiver: user).exists?
      Chatroom.where(receiver: user)
    else
      'No Chatrooms'
    end
  end

  def opposed_user(user)
    user == receiver ? sender : receiver
  end
end
