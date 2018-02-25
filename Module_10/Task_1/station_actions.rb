module Actions
  class StationActions < Action
    attr_reader :helper, :header

    def initialize(header)
      @header = header
      @helper = proc { Menu.new.station_menu }
    end

    def add(name)
      Station.new(name.shift)
    end

    def report(name)
      show_trains_on_station(Station.find(name.shift))
    end

    def all(*)
      Station.all.each { |station| puts station.id }
    end

    private

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
           train.type_get.ljust(11) +
           train.rolling_stock.size.to_s
    end
  end
end
