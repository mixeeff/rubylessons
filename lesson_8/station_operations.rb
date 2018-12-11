module StationOperations
  def create_station
    station_name = ask_user('Enter station name: ').capitalize
    station = Station.new(station_name)
    @my_railway.stations << station
    puts "Station #{station} created"
  end

  def show_stations
    return puts NO_STATIONS_ERROR unless @my_railway.stations?

    show_list(Station.all, 'Stations:')
    puts "total #{Station.instances} stations"
  end

  def show_trains_on_station
    return puts NO_TRAINS_ERROR unless @my_railway.trains?
    return puts NO_STATIONS_ERROR unless @my_railway.stations?

    station = choose_from_list(@my_railway.stations, 'station')
    return unless station
    return puts "No trains on station #{station}." unless station.trains?

    puts "Trains on station #{station}:"
    station.each_train { |train| puts train }
  end
end
