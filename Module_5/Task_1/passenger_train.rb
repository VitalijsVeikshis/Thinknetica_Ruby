require_relative 'train'
require_relative 'passenger_carriage'

class PassengerTrain < Train

  def connect_carriage(carriage)
    @rolling_stock << carriage if @speed.zero? && PassengerCarriage === carriage
  end
end
