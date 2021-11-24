class CallsController < ApplicationController
    def search
        @calls = LyricsVersion.search_calls_info(params[:keyword])
    end
    #TODO コールid → get_lyrics アクション → 歌詞を加工し、Jsonをクライアントに返す
end
