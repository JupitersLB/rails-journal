class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  validates :note, presence: true, uniqueness: true

  # Help find post from child comments
  def self.find_post(ele)
    if ele.commentable_type == 'Post'
      Post.find(ele.commentable_id)
    else
      c = Comment.find(ele.commentable_id)
      find_post(c)
    end
  end

  # Method to count all child comments for a post
  def deep_count
    count = comments.count
    comments.each { |c| count += c.deep_count }
    count
  end
end
