json.array! @calls do |call|
    json.id(call.id)
    json.title(call.song.title)
    json.artist(call.song.artist.name)
    json.creator("Admin")
end
