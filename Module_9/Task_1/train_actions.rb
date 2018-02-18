require_relative 'action'

module Actions
  class TrainActions < Action
    include Actions

    def initialize(header)
      @header = header
      @helper = proc { Menu.new.train_menu }
      @actions = actions_list
    end

    private

    def actions_list
      {
        add: proc { |params| add(params) },
        select: proc do |params|
          TrainSelectActions.new(@header, select_item(params)).run
        end,
        all: proc { all }
      }
    end

    def add(params)
      type = params.shift
      number = params.shift
      rate = params.shift.to_i
      route = params.shift.to_i
      train_by_type(type, number, rate, route)
      puts "Train is ready: type - #{type}, number - #{number}, " \
           "top speed - #{rate}, route - #{route}."
    end

    def train_by_type(type, number, rate, route)
      case type
      when 'passenger'
        PassengerTrain.new(id: number, rate: rate, route: Route.find(route))
      when 'cargo'
        CargoTrain.new(id: number, rate: rate, route: Route.find(route))
      else
        raise StandardError, 'Invalid train type: <passenger/cargo>'
      end
    end

    def select_item(train)
      Train.find(train.shift)
    end

    def all
      puts 'Number'.ljust(10) +
           'Route'.ljust(20) +
           'Type'.ljust(15) +
           'Roolling stock'
      Train.all.each do |train|
        train_info(train)
      end
    end

    def train_info(train)
      puts train.id.to_s.ljust(10) +
           train.route.name.ljust(20) +
           train.type.ljust(11) +
           train.rolling_stock.size.to_s
    end
  end
end
