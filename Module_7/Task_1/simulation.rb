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
    #Station.new('st1')
    #Station.new('st1')
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
      case command.shift
      when 'add'
        Station.new(command.shift)
      when 'report'
        show_trains(Station.find(command.shift).trains)
      when 'all'
        show_stations(Station.all)
      when 'exit'
        break
      else
        @menu.station_menu
      end
      break if command.join('').casecmp('exit') == 0
    rescue StandardError => e
      puts e.message
    end
  end

  def route
    loop do
      print 'Simulation > Route > '
      command = gets.chomp.downcase.split(' ')
      case command.shift
      when 'add'
        Route.new(Station.find(command.shift), Station.find(command.shift))
      when 'select'
        route_select(command.shift.to_i)
      when 'all'
        show_routes(Route.all)
      when 'exit'
        break
      else
        @menu.route_menu
      end
      break if command.join('').casecmp('exit') == 0
    rescue StandardError => e
      puts e.message
    end
  end

  def route_select(route_number)
    route = Route.find(route_number)
    loop do
      print "Simulation > Route > #{route_number} > "
      command = gets.chomp.downcase.split(' ')
      case command.shift
      when 'add'
        route.add_station(Station.find(command.shift))
      when 'delete'
        route.delete_station(Station.find(command.shift))
      when 'info'
        show_route(route)
      when 'exit'
        break
      else
        @menu.route_menu
      end
      break if command.join('').casecmp('exit') == 0
    rescue StandardError => e
      puts e.message
    end
  end

  def train
    loop do
      print 'Simulation > Train > '
      command = gets.chomp.downcase.split(' ')
      case command.shift
      when 'add'
        train_add(command)
      when 'select'
        train_select(command.shift)
      when 'all'
        show_trains(Train.all)
      when 'exit'
        break
      else
        @menu.train_menu
      end
      break if command.join('').casecmp('exit') == 0
    rescue StandardError => e
      puts e.message
    end
  end

  def train_select(train_number)
    train = Train.find(train_number)
    loop do
      print "Simulation > Train > #{train_number} > "
      command = gets.chomp.downcase.split(' ')
      case command.shift
      when 'connect'
        case command.shift
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
        train.add_route(Route.find(command.shift.to_i))
      when 'exit'
        break
      else
        @menu.train_menu
      end
      break if command.join('').casecmp('exit') == 0
    rescue StandardError => e
      puts e.message
    end
  end

  def train_add(command)
    type = command.shift
    number = command.shift
    rate = command.shift.to_i
    route = command.shift.to_i
    case type
    when 'passenger'
      PassengerTrain.new(number, rate, Route.find(route))
    when 'cargo'
      CargoTrain.new(number, rate, Route.find(route))
    else
      raise StandardError.new('Invalid train type: <passenger/cargo>')
    end
    puts "Train is ready: type - #{type}, number - #{number}, " +
         "top speed - #{rate}, route - #{route}."
  end

  def show_stations(stations)
    stations.each { |station| puts station.id }
  end

  def show_routes(routes)
    puts 'Stations'.ljust(10) +
         'Route name'
    routes.each { |route| puts route.id.to_s.ljust(10) + route.name.to_s }
  end

  def show_route(route)
    puts 'Stations'
    route.stations.each { |station| puts station.id }
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
