require_relative 'station'
require_relative 'route'
require_relative 'train'

test_stations = [Station.new('st1'), Station.new('st2'),
                 Station.new('st3'), Station.new('st4')]

test_route = Route.new(test_stations[0], test_stations[3])
test_route.show_route
puts '-------'
test_route.add_station(test_stations[1])
test_route.show_route
#puts '-------'
#test_route.delete_station(test_stations[1])
#test_route.show_route
puts '----------'

test_trains = [Train.new(1, 'Cargo', 5, 50, test_route),
               Train.new(2, 'Cargo', 10, 50, test_route),
               Train.new(3,'Passenger', 10, 250, test_route),
               Train.new(4,'Passenger', 0, 120, test_route)]

puts test_trains[3].rolling_stock
test_trains[3].connect_carriage
puts test_trains[3].rolling_stock
test_trains[3].disconnect_carriage
puts test_trains[3].rolling_stock
puts '---------'
#test_trains[0].add_route(test_route)
#test_trains[1].add_route(test_route)
#test_trains[2].add_route(test_route)
#test_trains[3].add_route(test_route)
test_trains[1].route.show_route

puts '-----------'
test_trains[1].forward
puts '-----------'
test_trains[1].forward
puts '-----------'
test_trains[1].back
puts '-----------'
test_stations[0].trains_by_type('Cargo').each { |type| p type }
