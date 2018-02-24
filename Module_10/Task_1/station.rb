require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'train'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :trains

  strong_attr_accessor(:id, String)

  validate :id, :presence
  validate :id, :type, String
  validate :stations, :singularity, :id

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
end
