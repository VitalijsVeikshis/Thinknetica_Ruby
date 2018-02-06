require_relative 'train'
require_relative 'passenger_carriage'

class PassengerTrain < Train

  def connect_carriage(carriage)
    super(carriage) if carriage.is_a?(PassengerCarriage)
  end
end
