class Admin::SongsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_song, only: [:edit, :update, :destroy]

    def new; end
    
    def index
        per_page = 5
        @page_length = (Song.all.count/per_page.to_f).ceil
        @songs = Song.includes(:artist).order(created_at: :desc).page(params[:page_num]).per(per_page)
    end

    def search_songs
        @songs = Song.order(created_at: :desc).search_songs(search_params[:keyword])
    end
    
    def create
        artist = Artist.find_by(artist_params)
        song = artist.songs.build(song_params)
        song.save!
        render json: {
            id: song.id,
            artist: {
                name: artist.name
            }
        }
    end
    
    def destroy
        @song.destroy!
    end
    
    def edit; end
    
    def update
        artist = Artist.find_by(artist_params)
        @song.update!(song_params.merge(artist: artist))
        render json: {
            id: @song.id,
            artist: {
                name: artist.name
            }
        }
    end
    
    private
    def search_params
        params.permit(:format, :keyword)
    end
    
    def song_params
        params.require(:song).permit(:title, :bpm)
    end
    
    def artist_params
        params.require(:artist).permit(:id)
    end

    def set_song
        @song = Song.find(params[:id])
    end
end
