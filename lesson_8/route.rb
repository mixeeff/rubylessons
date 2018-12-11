require_relative('instance_counter')

class Route
  include InstanceCounter

  ARGUMENT_ERROR = 'Argument must be Station Class'.freeze
  SAME_STATIONS_ERROR = 'Start and End stations must be different'.freeze

  attr_reader :stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    validate!
    @stations = [start_station, end_station]
    register_instance
    @number = Route.instances
  end

  def to_s
    "Route №#{@number} #{@start_station.name} - #{@end_station.name}"
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
    puts "Stations on route #{self}:"
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    unless @start_station.is_a?(Station) && @end_station.is_a?(Station)
      raise ARGUMENT_ERROR
    end
    raise SAME_STATIONS_ERROR if @start_station == @end_station
  end
end
