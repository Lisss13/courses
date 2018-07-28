vowels = {}

('a'..'z').each_with_index do |letter, index|
  vowels[letter] = index if letter.match /[aeoui]/
end

puts vowels