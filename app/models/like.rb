class Like < ApplicationRecord
  EMOJI_CODES = %w[&#128514 &#x1F60D &#x1F631 &#x1F973]
  belongs_to :post
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :value, inclusion: { in: EMOJI_CODES }
  validates :user, uniqueness: { scope: [:value, :post] }
end
