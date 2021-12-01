class Admin::ArtistsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_artist, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        @artists = Artist.all
    end

    def search_artists
        @artists = Artist.search_artists(search_params[:keyword])
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
