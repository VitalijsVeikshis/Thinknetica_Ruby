class Route
  attr_reader :stations, :number, :name

  @@routes_count = 0

  def initialize(initial_station, terminal_station)
    @stations = [initial_station, terminal_station]
    @name = "#{initial_station.name}-#{terminal_station.name}"
    @number = @@routes_count += 1
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
