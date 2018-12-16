# frozen_string_literal: true

module Validation
  VALUE_EMPTY_ERROR = 'cannot be nil or empty'
  VALUE_FORMAT_ERROR = "doesn't match the specified format"
  VALUE_TYPE_ERROR = "doesn't match the specified type"
  attr_writer :validations

  def validations
    @validations ||= []
  end

  def validate(name, validation_type, options = nil)
    var_name = "@#{name}".to_sym
    var_validation = { name: var_name, type: validation_type, options: options }
    validations << var_validation
    return if method_defined?(:validate!)

    define_method(:validate!) do
      self.class.validations.each do |var_validation|
        name = var_validation[:name]
        options = var_validation[:options]
        value = instance_variable_get(name)
        case var_validation[:type]
        when :presence
          raise "#{name} #{VALUE_EMPTY_ERROR}" if value.nil? || value == ''
        when :format
          raise "#{name} #{VALUE_FORMAT_ERROR}" if value !~ options
        when :type
          raise "#{name} #{VALUE_TYPE_ERROR}" unless value.is_a?(options) || value.nil?
        end
      end
    end

    define_method(:valid?) do
      validate!
      true
    rescue StandardError
      false
    end
  end
end
