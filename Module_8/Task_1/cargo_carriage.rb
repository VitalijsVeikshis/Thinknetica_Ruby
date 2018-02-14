require_relative 'carriage'

class CargoCarriage < Carriage
  def fill(amount)
    if @used + amount <= @capacity
      @used += amount
    else
      raise StandardError.new('Not enough space')
    end
  end
end
