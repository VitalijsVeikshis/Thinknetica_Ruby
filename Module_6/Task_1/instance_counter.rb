module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      ObjectSpace.each_object(self).to_a.size
    end
  end

  module InstanceMethods
    attr_reader :quantity

    @@quantity = 0

    private

    def register_instance
      @@quantity += 1
    end
  end
end
