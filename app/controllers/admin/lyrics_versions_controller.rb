class Admin::LyricsVersionsController < ApplicationController
    before_action :authenticate_user!
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
        lyrics_version.videos.create(tag: "recommend", url: video_params[:recommend][:url])
        lyrics_version.videos.create(tag: "official", url: video_params[:official][:url])
        # TODO IMPROVE： 返すJsonをJbuiderで作成する
        render json: { 
            id: lyrics_version.id,
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
            id: @lyrics_version.id,
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
    
    def video_params
        params.require(:video).permit(recommend: [:tag, :url], official: [:tag, :url])
    end
    
    def lyrics_version_params
        params.require(:lyrics_version).permit(:source)
    end

    def set_lyrics_version
        @lyrics_version = LyricsVersion.find(params[:id])
    end
end
