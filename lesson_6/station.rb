require_relative('instance_counter')

class Station
  include InstanceCounter
  attr_reader :name, :trains
  @@instances_list = {}
  
  def initialize(name)
    @name = name
    @trains =[]
    validate!
    register_instance
    @@instances_list[name] = self
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
    @@instances_list.values
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Name can't be nil" if name.nil?
    raise "Name can't be empty" if name.size.zero?
  end
end
