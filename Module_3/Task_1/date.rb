print 'Enter please date (dd/mm/yyyy):'
date = gets.chomp.split('/').map { |value| value.to_i }
day = date[0]
month = date[1]
year = date[2]

months = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]

if ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)
  months[2] = 29
end

puts "Day of year: #{months[0..(month - 1)].reduce(:+) + day}"
