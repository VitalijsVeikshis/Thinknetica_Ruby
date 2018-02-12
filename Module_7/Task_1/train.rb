require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :speed, :rate, :id, :route, :rolling_stock,
              :previous_station, :current_station, :next_station

  @@trains = {}
  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def self.all
    @@trains.values
  end

  def self.find(id)
    if @@trains[id].nil?
      raise StandardError.new("Train with number #{id} doesn't exist.")
    else
      @@trains[id]
    end
  end

  def initialize(id, rate, route)
    @id = id
    @rate = rate
    add_route(route)
    @speed = 0
    @rolling_stock = []
    @@trains[id] = self
    register_instance
  end

  def connect_carriage(carriage)
    @rolling_stock << carriage if @speed.zero?
  end

  def disconnect_carriage
    @rolling_stock.pop if @speed.zero? && @rolling_stock.size > 0
  end

  def add_route(route)
    @route = route
    validate!
    @position = 0
    current_station.arrival(self)
  end

  def forward
    if(current_station != @route.stations.last)
      current_station.departure(self)
      @position += 1
      current_station.arrival(self)
    end
  end

  def back
    if(current_station != @route.stations.first)
      current_station.departure(self)
      @position -= 1
      current_station.arrival(self)
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  #I don't use these methods outside class
  #I don't wana that the children's class changed these methods
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
    raise StandardError.new('Invalid train number: XXX-XX/XXXXX') if id.nil? || id !~ NUMBER_FORMAT
    raise StandardError.new('Invalid rate') if rate.nil? || rate <= 0
    raise StandardError.new('Invalid route') if  route.nil?
    true
  end
end
