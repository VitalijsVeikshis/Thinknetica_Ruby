fibonacci = [0, 1]

while (f = fibonacci[-1] + fibonacci[-2]) < 100 do
  fibonacci.push(f)
end

fibonacci.each_with_index { |number, index| puts "#{index}: #{number}" }
