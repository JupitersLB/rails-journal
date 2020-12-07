class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, :content, presence: true, uniqueness: true

  # Method to count all child comments for a post
  def deep_count
    count = comments.count
    comments.each { |c| count += c.deep_count }
    count
  end
end
