class Video < ApplicationRecord
  belongs_to :lyrics_version

  validates :tag, presence: true

  enum tag: { recommend: 0, guide: 1 }
end
