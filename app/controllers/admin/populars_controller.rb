class Admin::PopularsController < Admin::BaseController
    before_action :set_popular, only: [:edit, :update, :destroy]

    def new
        authorize(Popular)
    end

    def index
        authorize(Popular)
        @popular_words = Popular.all
    end
    
    def create
        authorize(Popular)
        popular_word = Popular.new(popular_word_params)
        popular_word.save!
        render json: { id: popular_word.id }
    end
    
    def destroy
        authorize(Popular)
        @popular_word.destroy!
    end
    
    def edit
        authorize(Popular)
    end

    def update
        authorize(Popular)
        @popular_word.update!(popular_word_params)
        render json: { id: @popular_word.id }
    end
    
    private
    def popular_word_params
        params.require(:popular).permit(:word)
    end

    def set_popular
        @popular_word = Popular.find(params[:id])
    end
end
