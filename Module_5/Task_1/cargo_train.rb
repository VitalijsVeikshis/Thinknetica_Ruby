require_relative 'train'
require_relative 'cargo_carriage'

class CargoTrain < Train

  def connect_carriage(carriage)
    super(carriage) if carriage.is_a?(CargoCarriage)
  end
end
