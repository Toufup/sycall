class Admin::LyricsVersionsController < Admin::BaseController
    before_action :set_lyrics_version, only: [:edit, :update, :destroy]
    before_action :search_lyrics_versions, only: [:index]

    def new
        authorize(LyricsVersion)
    end
    
    def index
        authorize(LyricsVersion)
        per_page = 5
        if params[:page_num]
            # 一覧表示用
            @lyrics_versions = @search_result.includes(:song, :language, song:[:artist])
                .page(params[:page_num]).per(per_page).order(created_at: :desc)
            @page_length = @lyrics_versions.total_pages
        else
            # 一般API検索用
            @lyrics_versions = @search_result.includes(:song, :language, song:[:artist]).order(created_at: :desc)
        end
    end

    def create
        authorize(LyricsVersion)
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        lyrics_version = song.lyrics_versions.build(lyrics_version_params)
        lyrics_version.language = language
        lyrics_version.save!
        lyrics_version.videos.create(tag: "recommend", url: video_params[:recommend][:url])
        lyrics_version.videos.create(tag: "guide", url: video_params[:guide][:url])
        render json: { 
            id: lyrics_version.id,
            song: {
                title: song.title
            }
        }
    end
    
    def destroy
        authorize(LyricsVersion)
        @lyrics_version.destroy!
    end
    
    def edit
        authorize(LyricsVersion)
    end
    
    def update
        authorize(LyricsVersion)
        song = Song.find_by(song_params)
        language = Language.find_by(language_params)
        @lyrics_version.update!(lyrics_version_params.merge(song: song, language: language))

        if recomment_url = @lyrics_version.videos.find_by(tag: "recommend")
            recomment_url.update!(url: video_params[:recommend][:url])
        else
            @lyrics_version.videos.create(tag: "recommend", url: video_params[:recommend][:url])
        end

        if guide_url = @lyrics_version.videos.find_by(tag: "guide")
            guide_url.update!(url: video_params[:guide][:url])
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

    def search_lyrics_versions
        @search_result = search_params[:keyword] ? LyricsVersion.search_lyrics_versions(search_params[:keyword]) : LyricsVersion.all
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
