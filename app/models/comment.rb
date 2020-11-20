class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  validates :note, presence: true, uniqueness: true

  def self.find_post(ele)
    if ele.commentable_type == 'Post'
      Post.find(ele.commentable_id)
    else
      c = Comment.find(ele.commentable_id)
      find_post(c)
    end
  end

  def deep_count
    count = comments.count
    comments.each { |c| count += c.deep_count }
    count
  end
end
