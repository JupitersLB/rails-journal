class FriendRequest < ApplicationRecord
  belongs_to :requestor, class_name: :User
  belongs_to :receiver, class_name: :User
  # validate :users_do_not_already_have_request

  def users_do_not_already_have_request
    if FriendRequest.where(requestor_id: receiver.id, receiver_id: requestor.id).exists? ||
       FriendRequest.where(requestor_id: requestor.id, receiver_id: receiver.id).exists?
      errors.add(:requestor, 'Friend request exists!')
    end
  end
end
