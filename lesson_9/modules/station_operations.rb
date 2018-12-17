# frozen_string_literal: true

require_relative('constants')

module StationOperations
  include Constants

  def create_station
    begin
      name = ask_user('Enter station name')
      station = Station.new(name)
    rescue StandardError => e
      puts e.message
      retry
    end
    @my_railway.stations << station
    puts "Station #{station} created."
  end

  def change_station_name
    return puts NO_STATIONS_ERROR unless @my_railway.stations?

    station = choose_from_list(@my_railway.stations, 'station')
    return unless station

    loop do
      station.name = ask_user('new name')
      break if station.valid?

      puts 'Name is not valid'
    end
    puts 'Station name changed'
  end

  def show_station_name_history
    return puts NO_STATIONS_ERROR unless @my_railway.stations?

    station = choose_from_list(@my_railway.stations, 'station')
    return unless station

    if station.name_history.empty?
      puts "Station #{station.name} hasn't been renamed"
    else
      puts "Previous names of #{station.name}:"
      puts station.name_history
    end
  end
end
