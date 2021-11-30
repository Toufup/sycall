class Admin::LyricsVersionsController < ApplicationController
    before_action :set_lyrics_version, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        @lyrics_versions = LyricsVersion.all.includes(:song, :language, song:[:artist])
    end

    def search_versions
        @lyrics_versions = LyricsVersion.search_versions(search_params[:keyword]).not_has_lyrics
    end

    def create
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        lyrics_version = song.lyrics_versions.build(lyrics_version_params)
        lyrics_version.language = language
        lyrics_version.save!
        # TODO IMPROVE： 返すJsonをJbuiderで作成する
        render json: { 
            song: {
                title: song.title
            }
        }
    end
    
    def destroy
        @lyrics_version.destroy!
    end
    
    def edit; end
    
    def update
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        @lyrics_version.update!(lyrics_version_params.merge(song: song, language: language))
        render json: { 
            song: {
                title: song.title
            }
        }
    end
    
    private
    def search_params
        params.permit(:format, :keyword)
    end
    
    def song_params
        params.require(:song).permit(:id)
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
