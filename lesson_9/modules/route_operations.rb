# frozen_string_literal: true

require_relative('constants')

module RouteOperations
  include Constants

  def create_route
    return puts NO_STATIONS_ERROR if Station.instances < 2

    start_station = choose_from_list(@my_railway.stations, 'start station')

    end_station_list = @my_railway.stations - [start_station]
    end_station = choose_from_list(end_station_list, 'end station')

    route = Route.new(start_station, end_station)
    @my_railway.routes << route
    puts "#{route} created."
  end

  def show_route_stations
    return puts NO_ROUTES_ERROR unless @my_railway.routes?

    route = choose_from_list(@my_railway.routes, 'route')
    return unless route

    puts route
    route.report
  end
end
