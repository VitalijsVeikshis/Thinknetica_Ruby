require_relative 'carriage'

class PassengerCarriage < Carriage
  def fill
    raise StandardError, 'Not enough space' if @used > @capacity
    @used += 1
  end
end
