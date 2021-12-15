class NewsController < ApplicationController
    def index
        @news = News.show_news
    end
end
