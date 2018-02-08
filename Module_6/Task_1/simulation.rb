require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'menu'

class Simulation
  def initialize
    @menu = Menu.new
  end

  def run
    @menu.main_menu
    loop do
      print 'Simulation > '
      command = gets.chomp.downcase
      case command
      when 'station'
        station
      when 'route'
        route
      when 'train'
        train
      when 'exit'
        break
      else
        @menu.main_menu
      end
      break if command.casecmp('exit') == 0
    end
  end

  private

  def station
    loop do
      print 'Simulation > Station > '
      command = gets.chomp.downcase.split(' ')
      case command.first
      when 'add'
        Station.new(command.last)
      when 'report'
        show_trains(Station.find(command.last).trains)
      when 'all'
        show_stations(Station.all)
      when 'exit'
        break
      else
        @menu.station_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def route
    loop do
      print 'Simulation > Route > '
      command = gets.chomp.downcase.split(' ')
      case command.first
      when 'add'
        Route.new(Station.find(command[1]), Station.find(command.last))
      when 'select'
        route_select(command.last.to_i)
      when 'all'
        show_routes(Route.all)
      when 'exit'
        break
      else
        @menu.route_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def route_select(route_number)
    route = Route.find(route_number)
    loop do
      print "Simulation > Route > #{route_number} > "
      command = gets.chomp.downcase.split(' ')
      case command.first
      when 'add'
        route.add_station(Station.find(command.last))
      when 'delete'
        route.delete_station(Station.find(command.last))
      when 'info'
        route.show_route
      when 'exit'
        break
      else
        @menu.route_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def train
    loop do
      print 'Simulation > Train > '
      command = gets.chomp.downcase.split(' ')
      case command.first
      when 'add'
        route = Route.find(command.last.to_i)
        case command[1]
        when 'passenger'
          PassengerTrain.new(command[2], command[3].to_i, route)
        when 'cargo'
          CargoTrain.new(command[2], command[3].to_i, route)
        end
      when 'select'
        train_select(command.last)
      when 'all'
        show_trains(Train.all)
      when 'exit'
        break
      else
        @menu.train_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def train_select(train_number)
    train = Train.find(train_number)
    loop do
      print "Simulation > Train > #{train_number} > "
      command = gets.chomp.downcase.split(' ')
      case command.first
      when 'connect'
        case command.last
        when 'cargo'
          train.connect_carriage(CargoCarriage.new)
        when 'passenger'
          train.connect_carriage(PassengerCarriage.new)
        end
      when 'disconnect'
        train.disconnect_carriage
      when 'forward'
        train.forward
      when 'back'
        train.back
      when 'assign'
        train.add_route(Route.find(command.last.to_i))
      when 'exit'
        break
      else
        @menu.train_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def show_stations(stations)
    stations.each { |station| puts station.id }
  end

  def show_routes(routes)
    puts 'Number'.ljust(10) +
         'Route name'
    routes.each { |route| puts route.id.to_s.ljust(10) + route.name.to_s }
  end

  def show_trains(trains)
    puts 'Number'.ljust(10) +
         'Route'.ljust(20) +
         'Type'.ljust(15) +
         'Roolling stock'
    trains.each do |train|
      puts train.id.to_s.ljust(10) +
           train.route.name.to_s.ljust(20) +
           train.class.to_s.ljust(15) +
           train.rolling_stock.size.to_s
    end
  end
end
