require_relative 'train'
require_relative 'cargo_carriage'

class CargoTrain < Train

  def connect_carriage(carriage)
    @rolling_stock << carriage if @speed.zero? && CargoCarriage === carriage
  end
end
