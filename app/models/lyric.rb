class Lyric < ApplicationRecord
  belongs_to :lyrics_version

  validates :body, presence: true

  scope :search_lyrics, -> (keyword) { 
    includes(lyrics_version: [:language, :song])
    .joins(lyrics_version: :song)
    .where("title LIKE ?", "%#{keyword}%")
  }
end
