require_relative 'train'
require_relative 'cargo_carriage'

class CargoTrain < Train
  def type
    'Cargo'
  end

  protected

  def carriage
    CargoCarriage.new
  end
end
