require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations, :id, :name

  @@routes = {}

  def self.all
    @@routes
  end

  def self.find(id)
    @@routes[id]
  end

  def initialize(initial_station, terminal_station)
    @stations = [initial_station, terminal_station]
    @name = "#{initial_station.id}-#{terminal_station.id}"
    register_instance
    @id = self.class.counter
    @@routes[@id] = self
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
