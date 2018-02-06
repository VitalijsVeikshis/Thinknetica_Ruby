require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'railway'
require_relative 'menu'

class Simulation
  def initialize
    @railway = Railway.new
    @menu = Menu.new
  end

  def run
    @menu.main_menu
    loop do
      print 'Simulation > '
      command = gets.chomp.downcase
      case command
      when 'station'
        station(@railway)
      when 'route'
        route(@railway)
      when 'train'
        train(@railway)
      when 'exit'
        break
      else
        @menu.main_menu
      end
      break if command.casecmp('exit') == 0
    end
  end

  private

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
        @menu.station_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def route(railway)
    loop do
      print 'Simulation > Route > '
      command = gets.chomp.downcase.split(' ')
      case command.first
      when 'add'
        railway.add_route(Route.new(Station.find(command[1]),
                          Station.find(command.last)))
      when 'select'
        route_select(command.last.to_i, railway)
      when 'all'
        railway.route_all
      when 'exit'
        break
      else
        @menu.route_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def route_select(route_number, railway)
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

  def train(railway)
    loop do
      print 'Simulation > Train > '
      command = gets.chomp.downcase.split(' ')
      case command.first
      when 'add'
        route = Route.find(command.last.to_i)
        case command[1]
        when 'passenger'
          railway.add_train(PassengerTrain.new(command[2], command[3].to_i, route))
        when 'cargo'
          railway.add_train(CargoTrain.new(command[2], command[3].to_i, route))
        end
      when 'select'
        train_select(command.last, railway)
      when 'all'
        railway.train_all
      when 'exit'
        break
      else
        @menu.train_menu
      end
      break if command.join('').casecmp('exit') == 0
    end
  end

  def train_select(train_number, railway)
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
end
