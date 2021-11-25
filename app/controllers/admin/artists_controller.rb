class Admin::ArtistsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
        @artists = Artist.all
    end

    def create
        artist = Artist.new(artists_params)
        artist.save!
    end
    
    def artists_params
        params.require(:artist).permit(:name)
    end
    
end
