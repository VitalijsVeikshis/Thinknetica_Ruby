module Actions
  class TrainSelectActions < Action
    include Actions

    def initialize(header, train)
      @header = "#{header}#{train.id} > "
      @helper = proc { Menu.new.train_menu }
      @train = train
      @actions = actions_list
    end

    private

    def actions_list
      {
        connect: proc { |params| connect(params) },
        disconnect: proc { @train.disconnect_carriage },
        fill: proc { |params| fill(params) },
        forward: proc { @train.forward },
        back: proc { @train.back },
        assign: proc { |params| assign(params) },
        info: proc { info }
      }
    end

    def connect(params)
      case params.shift
      when 'cargo'
        @train.connect_carriage(CargoCarriage.new(params.shift.to_i))
      when 'passenger'
        @train.connect_carriage(PassengerCarriage.new(params.shift.to_i))
      else
        raise StandardError, 'Invalid carriage type: <passenger/cargo>'
      end
    end

    def fill(params)
      @train.select_carriage(params.shift.to_i).fill(params.shift.to_i)
    end

    def assign(params)
      @train.add_route(Route.find(params.shift.to_i))
    end

    def info
      puts 'Number'.ljust(8) +
           'Type'.ljust(11) +
           'Used'.ljust(16) +
           'Remain'
      @train.each_carriage do |carriage|
        carriage_info(carriage)
      end
    end

    def carriage_info(carriage)
      puts carriage.number.to_s.ljust(8) +
           carriage.type.ljust(11) +
           carriage.used.to_s.ljust(16) +
           carriage.remain.to_s
    end
  end
end
