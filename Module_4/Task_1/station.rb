class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def trains_by_type(train_type = false)
    if train_type
      trains = @trains.map { |train| [train.number, train.type] }.to_h
      trains.select { |number, type| type == train_type }
    else
      types = @trains.map { |train| train.type }.uniq
      types.map { |type| [type, @trains.count{ |train| train.type == type }] }
           .to_h
    end
  end
end
