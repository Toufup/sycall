class Artist < ApplicationRecord
    has_many :songs, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    scope :search_artists, -> (keyword) { 
        where("name LIKE ?", "%#{keyword}%")
    }
end
