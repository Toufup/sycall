class Admin::LyricsVersionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lyrics_version, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        per_page = 5
        @page_length = (LyricsVersion.all.count/per_page.to_f).ceil
        @lyrics_versions = LyricsVersion.includes(:song, :language, song:[:artist]).order(created_at: :desc).page(params[:page_num]).per(per_page)
    end

    def search_versions
        @lyrics_versions = LyricsVersion.order(created_at: :desc).search_versions(search_params[:keyword])
    end

    def search_versions_to_edit
        @lyrics_versions = LyricsVersion.order(created_at: :desc).search_versions(search_params[:keyword]).not_has_lyrics
    end

    def create
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        lyrics_version = song.lyrics_versions.build(lyrics_version_params)
        lyrics_version.language = language
        lyrics_version.save!
        lyrics_version.videos.create(tag: "recommend", url: video_params[:recommend][:url])
        lyrics_version.videos.create(tag: "guide", url: video_params[:guide][:url])
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

        if recomment_url = @lyrics_version.videos.find_by(tag: "recommend")
            recomment_url.update!(url: video_params[:recommend][:url])
        else
            @lyrics_version.videos.create(tag: "recommend", url: video_params[:recommend][:url])
        end

        if guide_url = @lyrics_version.videos.find_by(tag: "guide")
            guide_url.update!(url: video_params[:recommend][:url])
        else
            @lyrics_version.videos.create(tag: "guide", url: video_params[:guide][:url])
        end

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
        params.require(:video).permit(recommend: [:tag, :url], guide: [:tag, :url])
    end
    
    def lyrics_version_params
        params.require(:lyrics_version).permit(:source)
    end

    def set_lyrics_version
        @lyrics_version = LyricsVersion.find(params[:id])
    end
end
