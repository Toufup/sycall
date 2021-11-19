class Song < ApplicationRecord
    belongs_to :artist
    has_many :videos, dependent: :destroy

    validates :title, presence: true
    validates :bpm, numericality: {only_integer: true}, allow_blank: true
end
