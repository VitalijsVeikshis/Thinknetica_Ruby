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
      type_error(attr_name) unless value.is_a?(attr_class)
      instance_variable_set(var_name, value)
    end
  end

  private

  def define_setter_with_history(attr_name)
    name = "@#{attr_name}_history".to_sym
    define_method("#{attr_name}=") do |value|
      instance_variable_set("@#{attr_name}".to_sym, value)
      instance_variable_set(name, []) if instance_variable_get(name).nil?
      unless instance_variable_get(name).last.equal?(value)
        instance_variable_get(name) << value
      end
    end
  end

  def type_error(attr_name)
    raise StandardError, "Invalid variable @#{attr_name} type"
  end
end
