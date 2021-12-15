class Admin::NewsController < Admin::BaseController
    before_action :set_a_news, only: [:edit, :update, :destroy]
    before_action :search_news, only: [:index]

    def new
        authorize(News)
    end
    
    def index
        authorize(News)
        per_page = 5
        if params[:page_num]
            @news = @search_result.page(params[:page_num]).per(per_page).order(created_at: :desc)
            @page_length = @news.total_pages
        else
            @news = @search_result.order(created_at: :desc)
        end
    end
    
    def create
        authorize(News)
        a_news = News.new(news_params)
        a_news.save!
        render json: { 
            id: a_news.id,
            createdAt: I18n.localize(a_news.created_at, format: "%Y/%m/%d")
        }
    end
    
    def destroy
        authorize(News)
        @a_news.destroy!
    end
    
    def edit
        authorize(News)
    end
    
    def update
        authorize(News)
        @a_news.update!(news_params)
        render json: { id: @a_news.id }
    end
    
    private
    def search_params
        params.permit(:format, :keyword)
    end

    def search_news
        @search_result = search_params[:keyword] ? News.search_news(search_params[:keyword]) : News.all
    end

    def news_params
        params.require(:news).permit(:title, :body)
    end

    def set_a_news
        @a_news = News.find(params[:id])
    end
end
