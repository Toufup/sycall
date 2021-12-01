json.array! @lyrics_versions do |version|
    json.id(version.id)
    json.title(version.song.title)
    json.bpm(version.song.bpm)
    json.artist(version.song.artist.name)
    json.language(version.language.name)
    json.creator("Admin")
end
