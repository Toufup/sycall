json.array! @popular_words do |popular_word|
    json.id popular_word.id
    json.word popular_word.word
end
