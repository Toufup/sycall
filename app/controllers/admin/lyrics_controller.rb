class Admin::LyricsController < ApplicationController
    before_action :set_lyrics_version, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        @lyrics = Lyric.all.includes(:lyrics_version, lyrics_version:[:song])
    end

    def search_versions
        @lyrics_versions = LyricsVersion.search_versions(call_params[:keyword]).not_has_lyrics
    end

    def create
        lyrics_version = LyricsVersion.find_by(lyrics_version_params)
        lyric = lyrics_version.build_lyric(lyric_params)
        lyric.save!
    end
    
    # def destroy
    #     @lyrics_version.destroy!
    # end
    
    # def edit; end
    
    # def update
    #     song = Song.find_by(song_params)
    #     language = Language.find_by(language_params)
    #     @lyrics_version.update!(lyrics_version_params.merge(song: song, language: language))
    # end
    
    private
    def call_params
        params.permit(:format, :keyword)
    end

    def lyrics_version_params
        params.require(:lyrics_version).permit(:id)
    end
    
    def lyric_params
        params.require(:lyric).permit(:body)
    end

    # def set_lyrics_version
    #     @lyrics_version = LyricsVersion.find(params[:id])
    # end
end
