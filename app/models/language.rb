class Language < ApplicationRecord
    has_many :lyrics_versions

    validates :name, presence: true, uniqueness: {case_sensitive: false}
end
