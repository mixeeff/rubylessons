# frozen_string_literal: true

module Validation
  VALUE_EMPTY_ERROR = 'Cannot be nil or empty'
  VALUE_FORMAT_ERROR = "Doesn't match the specified format"
  VALUE_TYPE_ERROR = "Doesn't match the specified type"

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :validations

    def validations
      @validations ||= []
    end

    def validate(name, validation_type, options = nil)
      validations << { name: name, type: validation_type, options: options }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}".to_sym)
        send("validate_#{validation[:type]}", value, validation[:options])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(value, _)
      raise VALUE_EMPTY_ERROR if value.nil? || value == ''
    end

    def validate_format(value, format)
      raise VALUE_FORMAT_ERROR if value !~ format
    end

    def validate_type(value, type)
      raise VALUE_TYPE_ERROR unless value.is_a?(type) || value.nil?
    end
  end
end
