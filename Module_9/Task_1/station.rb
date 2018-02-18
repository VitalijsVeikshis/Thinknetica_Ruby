require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :id, :trains

  @@stations = {}

  def self.all
    @@stations.values
  end

  def self.find(id)
    raise StandardError, "Station #{id} doesn't exist." if @@stations[id].nil?
    @@stations[id]
  end

  def initialize(id)
    @id = id
    @trains = []
    validate!
    @@stations[id] = self
    register_instance
  end

  def arrival(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def trains_info_by_type
    types = @trains.map(&:class).uniq
    types.map { |type| [type, @trains.count { |train| train.class == type }] }
         .to_h
  end

  def trains_by_type(train_type)
    trains = @trains.map { |train| [train.id, train.class] }.to_h
    trains.select { |_number, type| type.casecmp(train_type).zero? }
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  private

  def validate!
    raise StandardError, 'Invalid station name' if id.nil? || id.empty?
    if @@stations.include?(id)
      raise StandardError, 'Station name already is used'
    end
    true
  end
end
