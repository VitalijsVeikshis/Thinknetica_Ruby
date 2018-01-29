class Train
  attr_reader :speed, :rate, :type, :number, :route, :rolling_stock,
              :previous_station, :current_station, :next_station
  def initialize(number, type, rolling_stock, rate)
    @number = number
    @type = type
    @rolling_stock = rolling_stock
    @speed = 0
    @rate = rate
  end

  def accelerator
    @speed += @rate
  end

  def brake
    @speed -= @rate
  end

  def connect_carriage
    @rolling_stock += 1 if speed == 0
  end

  def disconnect_carriage
    @rolling_stock -= 1 if speed == 0 && rolling_stock > 0
  end

  def add_route(route)
    @route = route
    @position = 0
    @current_station = @route.route.first
    @next_station = @route.route[@position + 1]
    @current_station.arrival(self)

  end

  def forward
    if(@current_station != @route.route.last)
      @current_station.departure(self)
      puts @current_station.name
      puts accelerator
      @previous_station = @current_station
      @current_station = @next_station
      @current_station.arrival(self)
      puts @current_station.name
      puts brake
      @position += 1
      @next_station = @route.route[@position + 1] if @position + 1 < @route.route.length
    else
      puts 'Train can move only back!'
    end
  end

  def back
    if(@current_station != @route.route.first)
      @current_station.departure(self)
      puts @current_station.name
      puts accelerator
      @next_station = @current_station
      @current_station = @previous_station
      @current_station.arrival(self)
      puts @current_station.name
      puts brake
      @position -= 1
      @previous_station = @route.route[@position - 1] if @position - 1 > 0
    else
      puts 'Train can move only forward!'
    end
  end
end
