class Lyric < ApplicationRecord
  belongs_to :lyrics_version

  validates :body, presence: true
end
