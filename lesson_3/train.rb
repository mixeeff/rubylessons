class Train
  PASSENGER = 'passenger'
  FREIGHT = 'freight'

  attr_reader :number, :type, :carriages_count, :speed
  
  def initialize(number, type, carriages_count)
    @number = number
    @type = type
    @carriages_count = carriages_count
    @speed = 0
  end
  def speed_up(speed = 1)
    @speed += speed
  end
  def speed_down(speed = 1)
    @speed -= speed
    @speed = 0 if @speed < 0
    @speed
  end
  def add_carriage
    @carriages_count += 1 if @speed == 0
    @carriages_count
  end
  def remove_carriage
    @carriages_count -= 1 if @carriages_count > 0 && @speed == 0
    @carriages_count
  end
  def set_route(route)
    @route = route
    @route.stations[0].accept_train(self)
    @current_station_num = 0
    route
  end
  def next_station
    return unless @route
    return if @current_station_num == @route.stations.size - 1
    @route.stations[@current_station_num + 1]
  end
  def previous_station
    return unless @route
    return if @current_station_num == 0
    @route.stations[@current_station_num - 1]
  end
  def go_next_station
    return unless @route
    return unless next_station
    current_station = @route.stations[@current_station_num]
    current_station.send_train(self)
    next_station.accept_train(self)
    @current_station_num += 1
  end
  def go_previous_station
    return unless @route
    return unless previous_station
    current_station = @route.stations[@current_station_num]
    current_station.send_train(self)
    previous_station.accept_train(self)
    @current_station_num -= 1
  end
end
