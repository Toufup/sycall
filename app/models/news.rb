class News < ApplicationRecord
    scope :search_news, -> (keyword) { 
        where("title LIKE ?", "%#{keyword}%")
    }

    enum tag: { public: 0, archived: 1 }
end
