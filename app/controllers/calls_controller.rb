class CallsController < ApplicationController
    def search
        @lyrics_versions = LyricsVersion.search_versions(call_params[:keyword]).has_lyrics
    end

    def get_lyrics
        @call_lyrics = LyricsVersion.find(call_params[:callId]).lyric.body
    end
    
    private
    def call_params
        params.permit(:format, :keyword, :callId)
    end
end
