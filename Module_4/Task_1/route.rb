class Route
  attr_reader :stations
  def initialize(initial_station, terminal_station)
    @stations = [initial_station, terminal_station]
  end

  def add_station(station, order = -2)
    @stations.insert(order, station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.size > 2
  end

  def show_route
    @stations.each { |station| puts station.name }
  end
end
