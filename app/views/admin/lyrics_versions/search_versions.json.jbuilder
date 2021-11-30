json.array! @lyrics_versions do |version|
    json.id(version.id)
    json.title(version.song.title)
    json.artist(version.song.artist.name)
    json.language(version.language.name)
end
