require_relative 'train'
require_relative 'passenger_carriage'

class PassengerTrain < Train
  def type
    'Passenger'
  end

  protected

  def carriage
    PassengerCarriage.new
  end
end
