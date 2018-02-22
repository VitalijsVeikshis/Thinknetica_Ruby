module Actions
  class TrainActions < Action
    attr_reader :helper, :header

    def initialize(header)
      @header = header
      @helper = proc { Menu.new.train_menu }
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

    def chose(train)
      TrainSelectActions.new(@header, Train.find(train.shift))
    end

    def all(*)
      puts 'Number'.ljust(10) +
           'Route'.ljust(20) +
           'Type'.ljust(11) +
           'Roolling stock'
      Train.all.each do |train|
        train_info(train)
      end
    end

    private

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

    def train_info(train)
      puts train.id.to_s.ljust(10) +
           train.route.name.ljust(20) +
           train.type.ljust(11) +
           train.rolling_stock.size.to_s
    end
  end
end
