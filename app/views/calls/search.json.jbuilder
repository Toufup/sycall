json.array! @calls do |call|
    json.id(call.id)
    json.title(call.song.title)
    json.bpm(call.song.bpm)
    json.artist(call.song.artist.name)
    json.creator("Admin")
end
