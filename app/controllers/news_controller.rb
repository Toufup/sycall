class NewsController < ApplicationController
    def index
        @news = News.show_news
    end

    def show
        @a_news = News.find(params[:id])
    end
    
end
