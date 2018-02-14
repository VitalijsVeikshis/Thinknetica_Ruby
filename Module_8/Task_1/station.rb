require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :id, :trains

  @@stations = {}

  def self.all
    @@stations.values
  end

  def self.find(id)
    if @@stations[id].nil?
      raise StandardError.new("Station #{id} doesn't exist.")
    else
      @@stations[id]
    end
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
    types = @trains.map { |train| train.class }.uniq
    types.map { |type| [type, @trains.count{ |train| train.class == type }] }
         .to_h
  end

  def trains_by_type(train_type)
    trains = @trains.map { |train| [train.id, train.class] }.to_h
    trains.select { |number, type| type.casecmp(train_type) == 0 }
  end

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise StandardError.new('Invalid station name') if id.nil? || id.empty?
    raise StandardError.new('Station name already is used') if @@stations.include?(id)
    true
  end
end
