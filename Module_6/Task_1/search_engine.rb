module SearchEngine
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def find(id)
      ObjectSpace.each_object(self).to_a.find { |instance| instance.id == id }
    end
  end
end
