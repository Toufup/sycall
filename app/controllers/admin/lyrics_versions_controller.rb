class Admin::LyricsVersionsController < ApplicationController
    before_action :set_song, only: [:edit, :show, :update, :destroy]

    # def new; end
    
    def index
        @lyrics_versions = LyricsVersion.all.includes(:song, :language)
    end

    # def show; end
    
    # def create
    #     artist = Artist.find_by(artist_params)
    #     song = artist.songs.build(song_params)
    #     song.save!
    # end
    
    # def destroy
    #     @song.destroy!
    # end
    
    # def edit; end
    
    # def update
    #     @artist = @song.artist
    #     @song.update!(song_params)
    #     @artist.update!(artist_params)
    # end
    
    # private
    # def song_params
    #     params.require(:song).permit(:title, :bpm)
    # end
    
    # def artist_params
    #     params.require(:artist).permit(:name)
    # end

    # def set_song
    #     @song = Song.find(params[:id])
    # end
end
