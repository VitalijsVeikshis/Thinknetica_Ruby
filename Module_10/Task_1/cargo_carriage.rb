require_relative 'carriage'

class CargoCarriage < Carriage
  def fill(amount)
    raise StandardError, 'Not enough space' if @used + amount > @capacity
    @used += amount
  end
end
