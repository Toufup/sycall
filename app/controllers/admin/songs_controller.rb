class Admin::SongsController < ApplicationController
    def index
        @songs = Song.all.includes(:artist)
    end

    def show
        @song = Song.find(params[:id])
    end
    
    def create
        artist = Artist.find_by(artist_params)
        song = artist.songs.build(song_params)
        song.save!
    end
    
    def destroy
        song = Song.find(params[:id])
        song.destroy!
    end
    
    def update
        song = Song.find(params[:id])
        artist = song.artist
        song.update!(song_params)
        artist.update!(artist_params)
    end
    
    private
    def song_params
        params.require(:song).permit(:title, :bpm)
    end
    
    def artist_params
        params.require(:artist).permit(:name)
    end
end
