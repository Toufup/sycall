class Admin::ArtistsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_artist, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        per_page = 5
        @page_length = (Artist.all.count/per_page.to_f).ceil
        @artists = Artist.order(created_at: :desc).page(params[:page_num]).per(per_page)
    end

    def search_artists
        @artists = Artist.order(created_at: :desc).search_artists(search_params[:keyword])
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

    def artist_params
        params.require(:artist).permit(:name)
    end

    def set_artist
        @artist = Artist.find(params[:id])
    end
end
