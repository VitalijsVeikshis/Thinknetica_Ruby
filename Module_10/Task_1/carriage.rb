require_relative 'manufacturer'

class Carriage
  include Manufacturer

  attr_reader :capacity, :used
  attr_accessor :number

  def initialize(capacity)
    @capacity = capacity
    @used = 0
    @number = 0
  end

  def remain
    @capacity - @used
  end

  def get_type
    self.class.to_s[0..-9]
  end
end
