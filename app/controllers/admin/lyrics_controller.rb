class Admin::LyricsController < Admin::BaseController
    before_action :set_lyric, only: [:edit, :update, :destroy]
    before_action :search_lyrics, only: [:index]

    def new; end
    
    def index
        per_page = 5
        if params[:page_num]
            # 一覧表示用
            @lyrics = @search_result.includes(:lyrics_version, lyrics_version:[:song, :language])
                .page(params[:page_num]).per(per_page).order(created_at: :desc)
            @page_length = @lyrics.total_pages
        else
            # 一般API検索用
            @lyrics = @search_result.includes(:song, :language, song:[:artist]).order(created_at: :desc)
        end
    end

    def create
        lyrics_version = LyricsVersion.find_by(lyrics_version_params)
        lyric = lyrics_version.build_lyric(lyric_params)
        lyric.save!
        render json: {
            id: lyric.id,
            lyrics_version: {
                song: {
                    title: lyrics_version.song.title
                },
                language: {
                    name: lyrics_version.language.name
                }
            }
        }
    end
    
    def destroy
        @lyric.destroy!
    end
    
    def edit; end
    
    def update
        @lyric.update!(lyric_params)
        render json: {
            id: @lyric.id,
        }
    end
    
    private
    def search_params
        params.permit(:format, :keyword)
    end

    def search_lyrics
        @search_result = search_params[:keyword] ? Lyric.search_lyrics(search_params[:keyword]) : Lyric.all
    end

    def lyrics_version_params
        params.require(:lyrics_version).permit(:id)
    end
    
    def lyric_params
        params.require(:lyric).permit(:body)
    end

    def set_lyric
        @lyric = Lyric.find(params[:id])
    end
end
