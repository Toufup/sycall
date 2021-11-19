class LyricsVersion < ApplicationRecord
  belongs_to :song
  belongs_to :language

  validates :source, presence: true
end
