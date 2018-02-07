class Railway
  attr_reader :trains, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def add_train(train)
    @trains << train
  end

  def add_route(route)
    @routes << route
  end

  def add_station(station)
    @stations << station
  end
end
