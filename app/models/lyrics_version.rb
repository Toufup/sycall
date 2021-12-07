class LyricsVersion < ApplicationRecord
  belongs_to :song
  belongs_to :language
  has_many :videos, dependent: :destroy
  has_one :lyric, dependent: :destroy

  scope :search_versions, -> (keyword) {
    includes(:language, :song, song:[:artist])
    .joins(song: :artist)
    .where("songs.title LIKE ? OR artists.name LIKE ?", "%#{keyword}%", "%#{keyword}%")
  }
  # 歌詞が登録済みのもの
  scope :has_lyrics, -> { 
    includes(:lyric)
    .joins(:lyric)
    .where("lyrics.body IS NOT NULL")
  }
  # 歌詞が未登録のもの（Admin編集用）
  scope :not_has_lyrics, -> { 
    includes(:lyric)
    .where(lyrics: { body: nil })
  }

  validates :source, presence: true
end
