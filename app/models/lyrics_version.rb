class LyricsVersion < ApplicationRecord
  belongs_to :song
  belongs_to :language
  has_one :lyric, dependent: :destroy

  validates :source, presence: true
end
