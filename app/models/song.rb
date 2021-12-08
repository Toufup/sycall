class Song < ApplicationRecord
    belongs_to :artist
    has_many :lyrics_versions, dependent: :destroy

    validates :title, presence: true
    validates :bpm, numericality: {only_integer: true}, allow_blank: true

    scope :search_songs, -> (keyword) {
        includes(:artist)
        .where("title LIKE ?", "%#{keyword}%")
    }
end
