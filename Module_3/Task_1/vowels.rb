vowels_arr = ['а', 'е', 'ё', 'и', 'о', 'у', 'ы', 'э', 'ю', 'я']
vowels_hash = {
  'ё': 7
}

('а'..'я').each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels_arr.include?(letter)
end

vowels_hash = vowels_hash.sort_by{ |letter, index| index }.to_h

vowels_hash.each { |letter, index| puts "#{letter}: #{index}" }
