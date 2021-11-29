class Admin::SongsController < ApplicationController
    before_action :set_song, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        @songs = Song.all.includes(:artist)
    end

    def create
        artist = Artist.find_by(artist_params)
        song = artist.songs.build(song_params)
        song.save!
    end
    
    def destroy
        @song.destroy!
    end
    
    def edit; end
    
    def update
        artist = Artist.find_by(artist_params)
        @song.update!(song_params.merge(artist: artist))
    end
    
    private
    def song_params
        params.require(:song).permit(:title, :bpm)
    end
    
    def artist_params
        params.require(:artist).permit(:name)
    end

    def set_song
        @song = Song.find(params[:id])
    end
end
