class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :note, presence: true, uniqueness: true
end
