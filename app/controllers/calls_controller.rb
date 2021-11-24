class CallsController < ApplicationController
    def search
        @calls = LyricsVersion.search_calls_info(call_params[:keyword])
    end

    def get_lyrics
        @call_lyrics = LyricsVersion.find(call_params[:callId]).lyric.body
    end
    
    private
    def call_params
        params.permit(:format, :keyword, :callId)
    end
end
