class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts

  # friend requests
  has_many :friend_requests_as_requestor,
           foreign_key: :requestor_id,
           class_name: :FriendRequest
  has_many :friend_requests_as_receiver,
           foreign_key: :receiver_id,
           class_name: :FriendRequest

  # friendships
  has_many :friendships_as_friend_a,
           foreign_key: :friend_a_id,
           class_name: :Friendship
  has_many :friendships_as_friend_b,
           foreign_key: :friend_b_id,
           class_name: :Friendship

  # friends
  has_many :friend_as, through: :friendships_as_friend_b
  has_many :friend_bs, through: :friendships_as_friend_a

  def friends
    friend_as + friend_bs
  end
end
