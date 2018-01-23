print "What's your name? "
user_name = gets.chomp
print "How tall are you? "
user_height = gets.chomp.to_i
puts ""

optimal_weight = user_height - 110

if optimal_weight < 0
  puts "Your weight is already optimal!"
else
  puts "#{user_name}, your optimal weight is #{optimal_weight}."
end
