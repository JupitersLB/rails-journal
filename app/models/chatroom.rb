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

  # def self.get(sender, receiver)
  #   conversation = between(sender, receiver).first
  #   return conversation if conversation.present?

  #   create(sender: sender, receiver: receiver)
  # end

  def opposed_user(user)
    user == receiver ? sender : receiver
  end
end
