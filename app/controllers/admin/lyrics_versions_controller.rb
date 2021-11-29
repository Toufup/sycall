class Admin::LyricsVersionsController < ApplicationController
    before_action :set_lyrics_versions, only: [:edit, :show, :update, :destroy]

    def new; end
    
    def index
        @lyrics_versions = LyricsVersion.all.includes(:song, :language)
    end

    # def show; end
    
    def create
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        lyrics_version = song.lyrics_versions.build(lyrics_version_params)
        lyrics_version.language = language
        lyrics_version.save!
    end
    
    def destroy
        @lyrics_versions.destroy!
    end
    
    # def edit; end
    
    # def update
    #     @artist = @song.artist
    #     @song.update!(song_params)
    #     @artist.update!(artist_params)
    # end
    
    private
    def song_params
        params.require(:song).permit(:title)
    end
    
    def language_params
        params.require(:language).permit(:name)
    end
    
    def lyrics_version_params
        params.require(:lyrics_version).permit(:source)
    end

    def set_lyrics_versions
        @lyrics_versions = LyricsVersion.find(params[:id])
    end
end
