basket = Hash.new

loop do
  print 'Product: '
  product = gets.chomp
  break if product == 'stop'

  print 'Price: '
  price = gets.chomp.to_f

  print 'Quantity: '
  quantity = gets.chomp.to_f

  basket[product] = {price: price, quantity: quantity}
end

puts 'Product'.ljust(15) +
     'Price'.rjust(10) +
     'Quantity'.rjust(10) +
     'Sub-total'.rjust(10)
sub_totals = Array.new
basket.each do |name, property|
  sub_totals.push(property[:price] * property[:quantity])
  puts name.to_s.ljust(15) +
       property[:price].to_s.rjust(10) +
       property[:quantity].to_s.rjust(10) +
       (sub_totals.last).to_s.rjust(10)
end

puts "Total: #{sub_totals.reduce(:+)}".rjust(45)
