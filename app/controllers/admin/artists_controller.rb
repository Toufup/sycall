class Admin::ArtistsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_artist, only: [:edit, :update, :destroy]
    before_action :search_artists, only: [:index]

    def new; end
    
    def index
        per_page = 5
        if params[:page_num]
            @artists = @search_result.page(params[:page_num]).per(per_page).order(created_at: :desc)
            @page_length = @artists.total_pages
        else
            @artists = @search_result.order(created_at: :desc)
        end
    end
    
    def create
        artist = Artist.new(artist_params)
        artist.save!
        render json: { id: artist.id }
    end
    
    def destroy
        @artist.destroy!
    end
    
    def edit; end
    
    def update
        @artist.update!(artist_params)
        render json: { id: @artist.id }
    end
    
    private
    def search_params
        params.permit(:format, :keyword)
    end

    def search_artists
        @search_result = search_params[:keyword] ? Artist.search_artists(search_params[:keyword]) : Artist.all
    end

    def artist_params
        params.require(:artist).permit(:name)
    end

    def set_artist
        @artist = Artist.find(params[:id])
    end
end
