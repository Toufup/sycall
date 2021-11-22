class CallsController < ApplicationController
    def search
        keyword = params[:keyword]
        @calls = LyricsVersion.joins(song: :artist).where("songs.title LIKE ?", "%#{keyword}%")
                .or(LyricsVersion.joins(song: :artist).where("artists.name LIKE ?", "%#{keyword}%"))
    end
end
