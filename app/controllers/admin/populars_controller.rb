class Admin::PopularsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_popular, only: [:edit, :update, :destroy]

    def new; end

    def index
        @popular_words = Popular.all
    end
    
    def create
        
    end
    
    def destroy
        
    end
    
    def edit; end

    def update
        
    end
    
    private
    def popular_params
        params.require(:popular).permit(:word)
    end

    def set_popular
        @song = Popular.find(params[:id])
    end
end
