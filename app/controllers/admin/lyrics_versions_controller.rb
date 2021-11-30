class Admin::LyricsVersionsController < ApplicationController
    before_action :set_lyrics_version, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        @lyrics_versions = LyricsVersion.all.includes(:song, :language)
    end

    def create
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        lyrics_version = song.lyrics_versions.build(lyrics_version_params)
        lyrics_version.language = language
        lyrics_version.save!
        render json: { id: lyrics_version.id }
    end
    
    def destroy
        @lyrics_version.destroy!
    end
    
    def edit; end
    
    def update
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        @lyrics_version.update!(lyrics_version_params.merge(song: song, language: language))
    end
    
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

    def set_lyrics_version
        @lyrics_version = LyricsVersion.find(params[:id])
    end
end
