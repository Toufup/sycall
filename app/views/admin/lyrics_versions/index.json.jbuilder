json.lyricsVersions @lyrics_versions do |lyrics_version|
    json.id lyrics_version.id
    json.song do
        json.title lyrics_version.song.title
        json.artist do
            json.name lyrics_version.song.artist.name
        end
    end
    json.lyrics_version do
        json.source lyrics_version.source
    end
    json.language do
        json.name lyrics_version.language.name
    end
end
json.pageLength @page_length
