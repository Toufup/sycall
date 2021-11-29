json.array! @artists do |artist|
    json.id artist.id
    json.artist do
        json.name artist.name
    end
end
