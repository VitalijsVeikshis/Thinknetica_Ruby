module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :verifications

    def validate(*args)
      @verifications ||= []
      @verifications << args
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue StandardError => e
      puts e.message
      false
    end

    private

    def validate!
      self.class.verifications.each do |args|
        send(args[1], args[0], args[2])
      end
      true
    end

    def presence(var_name, *)
      value = get_instance_value(var_name)
      if value.nil? || value.empty?
        raise StandardError, "#{var_name} is nil or empty"
      end
      true
    end

    def format(var_name, var_format)
      if get_instance_value(var_name) !~ var_format
        raise StandardError, "Invalid #{var_name} format"
      end
      true
    end

    def type(var_name, var_type)
      unless get_instance_value(var_name).is_a?(var_type)
        raise StandardError, "Invalid #{var_name} type"
      end
      true
    end

    def singularity(hash_name, kye_name)
      hash_value = get_class_value(hash_name)
      key = get_instance_value(kye_name)
      if hash_value.include?(key) && !hash_value[key].equal?(self)
        raise StandardError, "#{var_name2} already is used"
      end
      true
    end

    def get_instance_value(var_name)
      instance_variable_get("@#{var_name}".to_sym)
    end

    def get_class_value(var_name)
      self.class.send(:class_variable_get, "@@#{var_name}".to_sym)
    end
  end
end
