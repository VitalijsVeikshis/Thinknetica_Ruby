require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :id, :trains

  @@stations = {}

  def self.all
    @@stations.values
  end

  def self.find(id)
    @@stations[id]
  end

  def initialize(id)
    @id = id
    @trains = []
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
end
