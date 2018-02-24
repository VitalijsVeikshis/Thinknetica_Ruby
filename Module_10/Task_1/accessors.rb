module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      define_method(name) { instance_variable_get("@#{name}".to_sym) }
      define_setter_with_history(name)
      define_method("#{name}_history") do
        instance_variable_get("@#{name}_history".to_sym)
      end
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_name) }
    define_method("#{attr_name}=") do |value|
      unless value.is_a?(attr_class)
        raise StandardError, "Invalid variable @#{attr_name} type"
      end
      instance_variable_set(var_name, value)
    end
  end

  private

  def define_setter_with_history(name)
    var_name = "@#{name}_history".to_sym
    define_method("#{name}=") do |value|
      instance_variable_set("@#{name}".to_sym, value)
      if instance_variable_get(var_name).nil?
        instance_variable_set(var_name, [])
      end
      unless instance_variable_get(var_name).last.equal?(value)
        instance_variable_get(var_name) << value
      end
    end
  end
end
