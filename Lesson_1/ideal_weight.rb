print "What's your name? "
user_name = gets.chomp
print "How tall are you? "
user_height = gets.chomp

optimal_weight = user_height.to_i - 110
puts "#{user_name}, your optimal weight is #{optimal_weight}."
if optimal_weight < 0
  print "Your weight is already optimal!"
end
