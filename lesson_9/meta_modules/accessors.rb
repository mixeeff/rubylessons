# frozen_string_literal: true

module Acсessors
  VALUE_TYPE_ERROR = "doesn't match the specified type"

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_name = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        old_name = instance_variable_get(var_name)
        instance_variable_set(var_name, value)
        history = instance_variable_get(history_name)
        if history.nil?
          instance_variable_set(history_name, [])
        else
          history << old_name
        end
      end

      define_method("#{name}_history") { instance_variable_get(history_name) }
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise "#{name} #{VALUE_TYPE_ERROR}" unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
end
