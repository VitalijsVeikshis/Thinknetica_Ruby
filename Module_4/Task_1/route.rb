class Route
  attr_reader :route
  def initialize(initial_station, terminal_station)
    @route = [initial_station, terminal_station]
  end

  def add_station(station, order = -2)
    @route.insert(order, station)
  end

  def delete_station(station)
    @route.delete(station) if @route.size > 2
  end

  def show_route
    @route.each { |station| puts station.name }
  end
end
