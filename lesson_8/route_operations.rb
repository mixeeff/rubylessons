require_relative('constants')

module RouteOperations
  include Constants

  def create_route
    return puts NO_STATIONS_ERROR if Station.instances < 2

    start_station = choose_from_list(@my_railway.stations, 'start station')
    return unless start_station

    end_station_list = @my_railway.stations - [start_station]
    end_station = choose_from_list(end_station_list, 'end station')
    return unless end_station

    route = Route.new(start_station, end_station)
    @my_railway.routes << route
    puts "#{route} created."
  end

  def show_routes
    return puts NO_ROUTES_ERROR unless @my_railway.routes?

    show_list(@my_railway.routes, 'Routes:')
    puts "total #{Route.instances} routes"
  end

  def show_route_stations
    return puts NO_ROUTES_ERROR unless @my_railway.routes?

    route = choose_route
    return unless route

    puts route
    route.report
  end

  def add_station_to_route
    return puts NO_ROUTES_ERROR unless @my_railway.routes?
    return puts NO_STATIONS_ERROR unless @my_railway.stations?

    route = choose_route
    return unless route

    adding_stations = @my_railway.stations - route.stations
    return puts "No stations to add to #{route}" if adding_stations.empty?

    station = choose_from_list(adding_stations, 'station to add')
    return unless station

    route.add_station(station)
    route.report
  end

  def delete_station_from_route
    return puts NO_ROUTES_ERROR unless @my_railway.routes?

    route = choose_route
    return unless route

    return puts "#{route} has only 2 stations" if route.stations.size > 2

    station = choose_from_list(route.stations, 'station to delete')
    return unless station

    route.delete_station(station)
    route.report
  end

  def set_train_to_route
    return puts NO_TRAINS_ERROR unless @my_railway.trains?
    return puts NO_ROUTES_ERROR unless @my_railway.routes?

    train = choose_train
    return unless train

    route = choose_route
    return unless route

    train.to_route(route)
    puts "#{train} now on #{route} on station #{train.current_station}"
  end
end
