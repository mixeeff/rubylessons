require_relative('instance_counter')

class Station
  include InstanceCounter
  attr_reader :name, :trains

  WRONG_NAME_ERROR = "Name must be String"
  EMRTY_NAME_ERROR = "Name can't be empty"
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

  def each_train
    return unless block_given?
    @trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise WRONG_NAME_ERROR unless name.is_a?(String)
    raise EMRTY_NAME_ERROR if name.strip.empty?
  end
end
