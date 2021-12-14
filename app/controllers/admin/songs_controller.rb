class Admin::SongsController < Admin::BaseController
    before_action :set_song, only: [:edit, :update, :destroy]
    before_action :search_songs, only: [:index]

    def new
        authorize(Song)
    end
    
    def index
        authorize(Song)
        per_page = 5
        if params[:page_num]
            @songs = @search_result.includes(:artist).page(params[:page_num]).per(per_page).order(created_at: :desc)
            @page_length = @songs.total_pages
        else
            @songs = @search_result.includes(:artist).order(created_at: :desc)
        end
    end

    def create
        authorize(Song)
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
        authorize(Song)
        @song.destroy!
    end
    
    def edit
        authorize(Song)
    end
    
    def update
        authorize(Song)
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
    
    def search_songs
        @search_result = search_params[:keyword] ? Song.search_songs(search_params[:keyword]) : Song.all
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
