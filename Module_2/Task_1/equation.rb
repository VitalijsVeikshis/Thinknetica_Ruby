print "a="
a = gets.chomp.to_f
print "b="
b = gets.chomp.to_f
print "c="
c = gets.chomp.to_f
puts ""

d = b**2 - 4 * a * c
puts "D=#{d}"

if d > 0
  puts "x1=#{(-b + Math.sqrt(d)) / (2 * a)} x2=#{(-b - Math.sqrt(d)) / (2 * a)}"
elsif d == 0
  puts "x=#{(-b / (2 * a))}"
else
  puts "There are no real roots."
end
