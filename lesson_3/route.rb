class Route
  attr_reader:stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
  end
  def insert_station(station)
    @stations.insert(-2, station)
    @stations
  end
  def delete_station(station)
    @stations.delete(station)
    @stations
  end
  def report
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}"}    
  end
end
