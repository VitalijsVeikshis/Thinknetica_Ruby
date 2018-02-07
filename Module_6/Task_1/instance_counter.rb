module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :counter

    private

    def increase_counter
      @counter ||= 0
      @counter += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :increase_counter
    end
  end
end
