class Admin::ArtistsController < ApplicationController
    before_action :set_artist, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        @artists = Artist.all
    end

    def create
        artist = Artist.new(artist_params)
        artist.save!
    end
    
    def destroy
        @artist.destroy!
    end
    
    def edit; end
    
    def update
        @artist.update!(artist_params)
    end
    
    private
    def artist_params
        params.require(:artist).permit(:name)
    end

    def set_artist
        @artist = Artist.find(params[:id])
    end
end
