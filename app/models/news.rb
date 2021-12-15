class News < ApplicationRecord
    scope :search_news, -> (keyword) { 
        where("title LIKE ?", "%#{keyword}%")
    }

    enum tag: { published: 0, archived: 1 }
end
