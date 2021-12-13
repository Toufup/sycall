class Admin::LyricsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lyric, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        per_page = 5
        @page_length = (Lyric.all.count/per_page.to_f).ceil
        @lyrics = Lyric.includes(:lyrics_version, lyrics_version:[:song, :language]).order(created_at: :desc).page(params[:page_num]).per(per_page)
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
    end
    
    private
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
