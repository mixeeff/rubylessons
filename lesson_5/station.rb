require_relative('instance_counter')

class Station
  include InstanceCounter
  set_instance_counter
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains =[]
    register_instance
  end

  def to_s
    name
  end

  def accept_train(train)
    @trains << train unless @trains.include?(train)
  end
  
  def send_train(train)
    @trains.delete(train)
    @trains
  end
  
  def has_trains?
    !@trains.empty?
  end

  def self.all
    instances_list
  end
end
