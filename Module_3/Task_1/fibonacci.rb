fibonacci = [0, 1]

loop do
  f = fibonacci[-1] + fibonacci[-2]
  if f < 100
    fibonacci.push(f)
  else
    break
  end
end

fibonacci.each_with_index { |number, index| puts "#{index}: #{number}" }
