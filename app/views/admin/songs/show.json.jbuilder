json.song do
    json.id @song.id
    json.title @song.title
    json.bpm @song.bpm
end 
json.artist do
    json.name @song.artist.name
end
