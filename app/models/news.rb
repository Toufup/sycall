class News < ApplicationRecord
    enum tag: { public: 0, archived: 1 }
end
