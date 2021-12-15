class News < ApplicationRecord
    scope :search_news, -> (keyword) { 
        where("title LIKE ?", "%#{keyword}%")
    }
    scope :show_news, -> { 
        where("tag = ?", "published")
    }

    enum tag: { published: 0, archived: 1 }
end
