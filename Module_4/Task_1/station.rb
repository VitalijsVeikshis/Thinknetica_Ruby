class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    @trains.push(train)
  end

  def departure(train)
    @trains.delete(train)
  end
  
  def trains_by_type
    trains = @trains.map { |train| train.type }
    types.uniq.map { |train_type| [train_type, trains.count(train_type)] }.to_h
  end
=begin
  def trains_by_type(train_type)
    trains = @trains.map { |train| [train.number, train.type] }.to_h
    trains.select { |number, type| type == train_type }
  end
=end
end
