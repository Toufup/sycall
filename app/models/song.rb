class Song < ApplicationRecord
    belongs_to :artist

    validates :title, presence: true
end
