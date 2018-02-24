require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :stations, :id, :name

  validate :name, :type, String

  @@routes = {}

  def self.all
    @@routes.values
  end

  def self.find(id)
    if @@routes[id].nil?
      raise StandardError, "Route number #{id} doesn't exist."
    end
    @@routes[id]
  end

  def initialize(options)
    unless options[:initial].is_a?(Station) &&
           options[:terminal].is_a?(Station)
      raise StandardError, 'Invalid station'
    end
    @stations = [options[:initial], options[:terminal]]
    @name = "#{options[:initial].id}-#{options[:terminal].id}"
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
end
