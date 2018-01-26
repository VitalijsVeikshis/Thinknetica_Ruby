vowels_arr = ['а', 'е', 'ё', 'и', 'о', 'у', 'ы', 'э', 'ю', 'я']
vowels_hash = {}

('а'..'я').to_a.insert(6, 'ё').each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels_arr.include?(letter)
end

vowels_hash.each { |letter, index| puts "#{letter}: #{index}" }
