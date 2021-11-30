json.song do
    json.title @song.title
    json.bpm @song.bpm
end 
json.artist do
    json.id @song.artist.id
    json.name @song.artist.name
end
