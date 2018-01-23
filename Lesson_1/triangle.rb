print "Length of a triangle first side: "
a = gets.chomp.to_f
print "Length of a triangle second side: "
b = gets.chomp.to_f
print "Length of a triangle third side: "
c = gets.chomp.to_f
puts ""

if a > b && a > c
  temp = c
  c = a
  a = temp
elsif b > a && b > c
  temp = c
  c = b
  b = temp
end

puts "This triangle is equilateral." if a == b && a == c
puts "This triangle is isosceles." if a == b || a == c || b == c
if c**2 == a**2 + b**2
  puts "This triangle is right."
else
  puts "This triangle is non-right."
end
