# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances += 1
    end
  end

  module ClassMethods
    attr_writer :instances
    def instances
      @instances ||= 0
    end

    def instances?
      !@instances.zero?
    end
  end
end
