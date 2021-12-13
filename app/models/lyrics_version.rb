class LyricsVersion < ApplicationRecord
  belongs_to :song
  belongs_to :language
  has_many :videos, dependent: :destroy
  has_one :lyric, dependent: :destroy

  scope :search_lyrics_versions, -> (keyword) {
    includes(:language, :song, song:[:artist])
    .joins(song: :artist)
    .where("songs.title LIKE ? OR artists.name LIKE ?", "%#{keyword}%", "%#{keyword}%")
  }

  validates :source, presence: true
end
