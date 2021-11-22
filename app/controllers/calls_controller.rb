class CallsController < ApplicationController
    def search
        @calls = LyricsVersion.search_calls_info(params[:keyword])
    end
end
