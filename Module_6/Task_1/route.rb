require_relative 'instance_counter'
require_relative 'search_engine'

class Route
  include InstanceCounter
  include SearchEngine

  attr_reader :stations, :id, :name

  def initialize(initial_station, terminal_station)
    @stations = [initial_station, terminal_station]
    @name = "#{initial_station.id}-#{terminal_station.id}"
    register_instance
    @id = @@quantity
  end

  def add_station(station, order = -2)
    @stations.insert(order, station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.size > 2
  end

  def show_route
    @stations.each { |station| puts station.id }
  end
end
