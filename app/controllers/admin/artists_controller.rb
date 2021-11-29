class Admin::ArtistsController < ApplicationController
    def index
        @artists = Artist.all
    end

    def show
        @artist = Artist.find(params[:id])
    end
    
    def create
        artist = Artist.new(artist_params)
        artist.save!
    end
    
    def destroy
        artist = Artist.find(params[:id])
        artist.destroy!
    end
    
    def update
        artist = Artist.find(params[:id])
        artist.update!(artist_params)
    end
    
    private
    def artist_params
        params.require(:artist).permit(:name)
    end
end
