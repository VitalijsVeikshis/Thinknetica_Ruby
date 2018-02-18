require_relative 'action'

module Actions
  class StationActions < Action
    include Actions

    def initialize(header)
      @header = header
      @helper = proc { Menu.new.station_menu }
      @actions = actions_list
    end

    private

    def actions_list
      {
        add: proc { |params| add(params) },
        report: proc { |params| report(params) },
        all: proc { all }
      }
    end

    def add(name)
      Station.new(name.shift)
    end

    def report(name)
      show_trains_on_station(Station.find(name.shift))
    end

    def all
      Station.all.each { |station| puts station.id }
    end

    def show_trains_on_station(station)
      puts 'Number'.ljust(10) +
           'Route'.ljust(20) +
           'Type'.ljust(11) +
           'Roolling stock'
      station.each_train do |train|
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
