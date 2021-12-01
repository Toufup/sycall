class Admin::LyricsController < ApplicationController
    before_action :set_lyric, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        @lyrics = Lyric.all.includes(:lyrics_version, lyrics_version:[:song, :language])
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
