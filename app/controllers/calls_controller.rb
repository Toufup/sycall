class CallsController < ApplicationController
    def search
        @lyrics_versions = LyricsVersion.search_lyrics_versions(call_params[:keyword])
    end

    def get_lyrics_count
        @lyrics_versions_count = Lyric.count
        render json: { lyrics: { count: @lyrics_versions_count } }
    end

    def get_popular_words
        @popular_words = Popular.all
    end    

    def get_lyrics
        @call_lyrics = LyricsVersion.find(call_params[:callId]).lyric.body
    end
    
    private
    def call_params
        params.permit(:format, :keyword, :callId)
    end
end
