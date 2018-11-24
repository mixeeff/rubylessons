class Route
  attr_reader:stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
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
  
end
