require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations, :id, :name

  @@routes = {}

  def self.all
    @@routes.values
  end

  def self.find(id)
    if @@routes[id].nil?
      raise StandardError.new("Route number #{id} doesn't exist.")
    else
      @@routes[id]
    end
  end

  def initialize(initial_station, terminal_station)
    @stations = []
    add_station(initial_station, 0)
    add_station(terminal_station, 1)
    @name = "#{initial_station.id}-#{terminal_station.id}"
    register_instance
    @id = self.class.counter
    @@routes[@id] = self
  end

  def add_station(station, order = -2)
    @stations.insert(order, station) if validate(station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.size > 2
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    unless stations.all? { |station| station.is_a?(Station) }
      raise StandardError.new('Invalid station')
    end
    true
  end

  def validate(station)
    raise StandardError.new('Invalid station') unless station.is_a?(Station)
    true
  end
end
