class Song < ApplicationRecord
    belongs_to :artist

    validates :title, presence: true
    validates :bpm, numericality: {only_integer: true}, allow_blank: true
end
