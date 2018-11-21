class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains =[]
  end

  def accept_train(train)
    @trains << train unless @trains.include?(train)
  end
  
  def send_train(train)
    @trains.delete(train)
    @trains
  end
  
  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end
  
end
