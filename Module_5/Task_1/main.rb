require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'railway'

TAB1 = 10
TAB2 = 34

def menu
  station_manual
  route_manual
  train_manual
  puts 'exit'.rjust(TAB1)
end

def train_manual
  print 'train '.rjust(TAB1)
  puts '> add <passenger/cargo> <speed> <route_number>'
  print ''.rjust(TAB1)
  puts '> select <train number> > connect'
  print ''.rjust(TAB2)
  puts '> disconnect'
  print ''.rjust(TAB2)
  puts '> forward'
  print ''.rjust(TAB2)
  puts '> back'
  print ''.rjust(TAB2)
  puts '> assign <route_number>'
  print ''.rjust(TAB2)
  puts '< exit'
  print ''.rjust(TAB1)
  puts '> all'
  print ''.rjust(TAB1)
  puts '< exit'
end

def route_manual
  print 'route '.rjust(TAB1)
  puts '> add <initial_station> <terminal_station>'
  print ''.rjust(TAB1)
  puts '> select <route number> > add <station_number>'
  print ''.rjust(TAB2)
  puts '> delete <station_number>'
  print ''.rjust(TAB2)
  puts '> info'
  print ''.rjust(TAB2)
  puts '< exit'
  print ''.rjust(TAB1)
  puts '> all'
  print ''.rjust(TAB1)
  puts '< exit'
end

def station_manual
  print 'station '.rjust(TAB1)
  puts '> add <name>'
  print ''.rjust(TAB1)
  puts '> report <name>'
  print ''.rjust(TAB1)
  puts '> all'
  print ''.rjust(TAB1)
  puts '< exit'
end

def station(railway)
  loop do
    print 'Simulation > Station > '
    command = gets.chomp.downcase.split(' ')
    case command.first
      when 'add'
        railway.add_station(Station.new(command.last))
      when 'report'
        railway.station_report(command.last)
      when 'all'
        railway.station_all
      when 'exit'
        break
      else
        station_manual
    end
    break if command.join('').downcase == 'exit'
  end
end

def route(railway)
  loop do
    print 'Simulation > Route > '
    command = gets.chomp.downcase.split(' ')
    case command.first
      when 'add'
        railway.add_route(Route.new(railway.find_station(command[1]), railway.find_station(command.last)))
      when 'select'
        route_select(command.last.to_i, railway)
      when 'all'
        railway.route_all
      when 'exit'
        break
      else
        route_manual
    end
    break if command.join('').downcase == 'exit'
  end
end

def route_select(route_number, railway)
  route = railway.find_route(route_number)
  loop do
    print "Simulation > Route > #{route_number} > "
    command = gets.chomp.downcase.split(' ')
    case command.first
      when 'add'
        route.add_station(railway.find_station(command.last))
      when 'delete'
        route.delete_station(railway.find_station(command.last))
      when 'info'
        route.show_route
      when 'exit'
        break
      else
        route_manual
    end
    break if command.join('').downcase == 'exit'
  end
end

def train(railway)
  loop do
    print 'Simulation > Train > '
    command = gets.chomp.downcase.split(' ')
    case command.first
      when 'add'
        route = railway.find_route(command.last.to_i)
        case command[1]
          when 'passenger'
            railway.add_train(PassengerTrain.new(command[2].to_i, route))
          when 'cargo'
            railway.add_train(CargoTrain.new(command[2].to_i, route))
        end
      when 'select'
        train_select(command.last.to_i, railway)
      when 'all'
        railway.train_all
      when 'exit'
        break
      else
        train_manual
    end
    break if command.join('').downcase == 'exit'
  end
end

def train_select(train_number, railway)
  train = railway.find_train(train_number)
  loop do
    print "Simulation > Train > #{train_number} > "
    command = gets.chomp.downcase.split(' ')
    case command.first
      when 'connect'
        train.connect_carriage
      when 'disconnect'
        train.disconnect_carriage
      when 'forward'
        train.forward
      when 'back'
        train.back
      when 'assign'
        train.add_route(railway.find_route(command.last.to_i))
      when 'exit'
        break
      else
        train_manual
    end
    break if command.join('').downcase == 'exit'
  end
end

menu
railway = Railway.new

loop do
  print 'Simulation > '
  command = gets.chomp.downcase
  case command
    when 'station'
      station(railway)
    when 'route'
      route(railway)
    when 'train'
      train(railway)
    when 'exit'
      break
    else
      menu
  end
  break if command.downcase == 'exit'
end
