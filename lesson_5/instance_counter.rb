module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    private
    def register_instance
      self.class.instances += 1
      self.class.instances_list << self
    end
  end

  module ClassMethods
    attr_accessor :instances, :instances_list
    
    def has_instances?
      !@instances.zero?
    end

    private
    def set_instance_counter
      @instances ||= 0
      @instances_list ||= []
    end
  end
  
end
