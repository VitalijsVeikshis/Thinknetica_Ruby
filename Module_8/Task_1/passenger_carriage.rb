require_relative 'carriage'

class PassengerCarriage < Carriage
  def fill
    if @used < @capacity
      @used += 1
    else
      raise StandardError.new('Not enough space')
    end
  end
end
