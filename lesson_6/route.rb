require_relative('instance_counter')

class Route
  include InstanceCounter
  attr_reader :stations

  ARGUMENT_ERROR = "Argument mus be Station Class"
  SAME_STATIONS_ERROR = "Start and End stations must be different"

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    validate!
    @stations = [start_station, end_station]
    register_instance
  end

  def to_s
    @start_station.name + ' - ' + @end_station.name
  end

  def add_station(station)
    @stations.insert(-2, station)
    @stations
  end

  def delete_station(station)
    @stations.delete(station)
    if @stations.size == 2
      @start_station = @stations[0]
      @end_station = @stations[1]
    end
    @stations
  end

  def report
    puts "Stations on route #{self.to_s}:"
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}"}    
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise ARGUMENT_ERROR unless @start_station.is_a?(Station) && @end_station.is_a?(Station)  
    raise SAME_STATIONS_ERROR if @start_station == @end_station
  end
  
end
