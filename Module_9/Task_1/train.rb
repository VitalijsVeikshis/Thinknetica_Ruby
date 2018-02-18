require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :speed, :rate, :id, :route, :rolling_stock

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  @@trains = {}

  def self.all
    @@trains.values
  end

  def self.find(id)
    if @@trains[id].nil?
      raise StandardError, "Train with number #{id} doesn't exist."
    end
    @@trains[id]
  end

  def initialize(options)
    @id = options[:id]
    @rate = options[:rate]
    add_route(options[:route])
    @speed = 0
    @rolling_stock = []
    @@trains[@id] = self
    register_instance
  end

  def connect_carriage(carriage)
    raise StandardError, 'Invalid carriage' unless carriage.is_a?(Carriage)
    raise StandardError, 'Stop train' unless @speed.zero?
    @rolling_stock << carriage
    carriage.number = @rolling_stock.size
  end

  def disconnect_carriage
    @rolling_stock.pop if @speed.zero? && !@rolling_stock.empty?
  end

  def select_carriage(number)
    @rolling_stock[number - 1]
  end

  def add_route(route)
    @route = route
    validate!
    @position = 0
    current_station.arrival(self)
  end

  def forward
    if current_station == @route.stations.last
      raise StandardError, "You can't move forward, this is the last station."
    end
    current_station.departure(self)
    @position += 1
    current_station.arrival(self)
  end

  def back
    if current_station != @route.stations.first
      raise StandardError, "You can't move back, this is the first station."
    end
    current_station.departure(self)
    @position -= 1
    current_station.arrival(self)
  end

  def each_carriage
    @rolling_stock.each { |carriage| yield(carriage) }
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def type
    self.class.to_s[0..-6]
  end

  # I don't use these methods outside class
  # I don't wana that the children's class changed these methods
  private

  def accelerator
    @speed += @rate
  end

  def brake
    @speed -= @rate if @speed >= @rate
  end

  def next_station
    @route.stations[@position + 1] if @position + 1 < @route.stations.length
  end

  def previous_station
    @route.stations[@position - 1] if @position - 1 > 0
  end

  def current_station
    @route.stations[@position]
  end

  def validate!
    if id.nil? || id !~ NUMBER_FORMAT
      raise StandardError, 'Invalid train number: XXX-XX/XXXXX'
    end
    raise StandardError, 'Invalid rate' if rate.nil? || rate <= 0
    raise StandardError, 'Invalid route' unless route.is_a?(Route)
    true
  end
end
