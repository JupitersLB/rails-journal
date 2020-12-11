class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  has_one_attached :photo

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

  # notifications

  has_many :notifications, foreign_key: :recipient_id

  include PgSearch::Model
  pg_search_scope :search_by_username,
                  against: :username,
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }

  # get all the friends
  def friends
    friend_as + friend_bs
  end

  # custom label for rails-admin gem page
  def custom_label_method
    username
  end
end
