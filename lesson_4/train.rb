class Train
  attr_reader :number, :speed, :carriages
  
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
  end

  def to_s
    'Train №' + number
  end

  def speed_up(speed = 1)
    @speed += speed
  end
  
  def speed_down(speed = 1)
    @speed -= speed
    @speed = 0 if @speed < 0
    @speed
  end
  
  def set_route(route)
    @route = route
    @route.stations[0].accept_train(self)
    @current_station_num = 0
    route
  end

  def on_route?
    @route
  end

  def has_carriages?
    !@carriages.empty?
  end

  def go_next_station
    return unless @route
    return unless next_station
    current_station.send_train(self)
    next_station.accept_train(self)
    @current_station_num += 1
    current_station
  end
  
  def go_previous_station
    return unless @route
    return unless previous_station
    current_station.send_train(self)
    previous_station.accept_train(self)
    @current_station_num -= 1
    current_station
  end

  def current_station
    return unless @route
    @route.stations[@current_station_num]
  end

  protected
  #метод будет переопределен в потомках
  def add_carriage(carriage)
    return unless speed == 0
    carriage.owner.remove_carriage(carriage) if carriage.owner
    @carriages << carriage
    carriage.owner = self
  end

  def remove_carriage(carriage)
    return unless speed == 0
    @carriages.delete(carriage)
    carriage.owner = nil
  end

  private
  # назначены как private т.к. используются только в методах go_next_station и go_previous_station

  def next_station
    return unless @route
    @route.stations[@current_station_num + 1]
  end
  
  def previous_station
    return unless @route
    return if @current_station_num == 0
    @route.stations[@current_station_num - 1]
  end
end
