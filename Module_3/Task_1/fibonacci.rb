fibonacci = [0, 1]

(2..100).each do
  fibonacci.push(fibonacci[-1] + fibonacci[-2])
end

fibonacci.each_with_index { |number, index| puts "#{index}: #{number}" }
