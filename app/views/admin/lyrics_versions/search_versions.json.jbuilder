json.lyrics_versions @lyrics_versions do |version|
    json.id version.id
    json.source version.source
    json.song do
        json.title version.song.title
        json.artist do
            json.name version.song.artist.name
        end
    end
    json.language do
        json.name version.language.name
    end
end
