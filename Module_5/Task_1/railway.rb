class Railway
  attr_reader :trains, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def add_train(train)
    @trains << train
    p @trains
  end

  def add_route(route)
    @routes << route
    p @routes
  end

  def add_station(station)
    @stations << station
    p @stations
  end

  def station_report(name)
    train_all(@stations.find { |station| station.name == name }.trains)
  end

  def station_all
    @stations.each { |station| puts station.name }
  end

  def route_all
    puts 'Number'.ljust(10) +
         'Route name'
    @routes.each { |route| puts route.number.to_s.ljust(10) + route.name.to_s }
  end

  def train_all(list = @trains)
    puts 'Number'.ljust(10) +
         'Route'.ljust(20) +
         'Type'.ljust(15) +
         'Roolling stock'
    list.each do |train|
      puts train.number.to_s.ljust(10) +
           train.route.name.to_s.ljust(20) +
           train.class.to_s.ljust(15) +
           train.rolling_stock.size.to_s
    end
  end

  def find_train(train_number)
    @trains.find { |train| train.number == train_number }
  end

  def find_route(route_number)
    @routes.find { |route| route.number == route_number }
  end

  def find_station(station_name)
    @stations.find { |station| station.name == station_name }
  end
end
