class LyricsVersion < ApplicationRecord
  belongs_to :song
  belongs_to :language
  has_one :lyric, dependent: :destroy

  scope :search_calls_info, -> (keyword) {
    includes(:song, song:[:artist])
    .joins(song: :artist)
    .where("songs.title LIKE ? OR artists.name LIKE ?", "%#{keyword}%", "%#{keyword}%")
  }

  validates :source, presence: true
end
