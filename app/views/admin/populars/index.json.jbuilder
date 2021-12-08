json.array! @popular_words do |popular_word|
    json.id popular_word.id
    json.popular do
        json.word popular_word.word
    end
end
