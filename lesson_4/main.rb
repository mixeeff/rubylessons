require_relative('station')
require_relative('route')
require_relative('train')
require_relative('passenger_train')
require_relative('cargo_train')
require_relative('carriage')
require_relative('railway')

NO_STATIONS_ERROR = 'First create at list 2 stations.'
NO_ROUTES_ERROR = 'First create at least 1 route.'
NO_TRAINS_ERROR = 'First create at least 1 train.'

main_menu = [
  'Create station',#0
  'Create train',#1
  'Create route',#2
  'Show route stations',#3
  'Add station to route',#4
  'Delete station from route',#5
  'Set train to route',#6
  'Create carriage',#7
  'Add carriage to train',#8
  'Remove carriage from train',#9
  'Show carriages of train',#10
  'Move train forward',#11
  'Move train backward',#12
  'Show stations',#13
  'Show train on station',#14
  'Quit'#15
]

def show_list(list)
  list.each.with_index(1) { |object, index| puts "#{index}. #{object}" }
end

def choose_from_list(list, description)
  if list.size.zero?
    puts "No items"
    return
  else
    puts "Choose #{description}: "
    show_list(list)
    print '>> '
    choise = gets.to_i - 1
    { index: choise, item: list[choise] }
  end
end

def choose_route(railway)
  choose_from_list(railway.routes, 'route')[:item]
end

def choose_train(railway)
  choose_from_list(railway.trains, 'train')[:item]
end

def create_station(railway)
  print 'Enter station name: '
  station_name = gets.chomp.capitalize
  station = Station.new(station_name)
  railway.add_station(station)
  puts "Station #{station} created"
end

def create_train(railway)
  print 'Enter train number: '
  train_number = gets.chomp
  train_type = choose_from_list(Railway::TRAIN_TYPES, "type of the train #{train_number}")[:item]
  if train_type == Railway::TRAIN_TYPES[0]
    train = Passenger_train.new(train_number)
  elsif train_type == Railway::TRAIN_TYPES[1]
    train = Cargo_train.new(train_number)
  end
  railway.add_train(train)
  puts "#{train} created."
end

def create_route(railway)
  if railway.stations.size < 2
    puts NO_STATIONS_ERROR
  else
    start_station = choose_from_list(railway.stations, 'start station')[:item]
    end_station_list = railway.stations - [start_station]
    end_station = choose_from_list(end_station_list, 'end station')[:item]
    route = Route.new(start_station, end_station)
    railway.add_route(route)
    puts "Route #{route} created."
  end
end

def show_route_stations(railway)
  unless railway.has_routes?
    puts NO_ROUTES_ERROR
    return
  end
  route = choose_route(railway)
  route.report
end

def add_station_to_route(railway)
  unless railway.has_routes?
    puts NO_ROUTES_ERROR
    return
  end
  unless railway.has_stations?
    puts NO_STATIONS_ERROR
    return
  end

  route = choose_route(railway)
  adding_stations = railway.stations - route.stations
  if adding_stations.size.zero?
    puts "There are no stations to add to route #{route}"
  else
    station = choose_from_list(adding_stations, 'station to add')[:item]
    route.add_station(station)
    route.report
  end
end

def delete_station_from_route(railway)
  unless railway.has_routes?
    puts NO_ROUTES_ERROR
    return
  end

  route = choose_route(railway)
  if route.stations.size > 2
    station = choose_from_list(route.stations, 'station to delete')[:item]
    route.delete_station(station)
    route.report
  else
    puts 'This route has only 2 stations. It cannot be deleted'
  end
end

def set_train_to_route(railway)
  unless railway.has_trains?
    puts NO_TRAINS_ERROR
    return
  end
  unless railway.has_routes?
    puts NO_ROUTES_ERROR
    return
  end
  
  train = choose_train(railway)
  route = choose_route(railway)
  train.set_route(route)
  puts ("#{train} now on the route #{route} on station #{train.current_station}")
end

def create_carriage(railway)
  print 'Enter carriage number: '
  carriage_number = gets.chomp
  carriage_type = choose_from_list(Railway::TRAIN_TYPES, "type of the carriage #{carriage_number}")[:item]
  if carriage_type == Railway::TRAIN_TYPES[0]
    carriage = Passenger_carriage.new(carriage_number)
  elsif carriage_type == Railway::TRAIN_TYPES[1]
    carriage = Cargo_carriage.new(carriage_number)
  end
  railway.add_carriage(carriage)
  puts "#{carriage} created."
end

def add_carriage_to_train(railway)
  unless railway.has_trains?
    puts NO_TRAINS_ERROR
    return
  end
  
  train = choose_train(railway)
  if train.class == Passenger_train
    carriage_list = railway.passenger_carriages - train.carriages
  elsif train.class == Cargo_train
    carriage_list = railway.cargo_carriages - train.carriages
  end
  if carriage_list.empty?
    puts 'There are no suitable carriages for this train.'
    return
  end
  carriage = choose_from_list(carriage_list, 'carriage')[:item]
  train.add_carriage(carriage)
  puts "#{carriage} attached to #{train}"
end

def remove_carriage_from_train(railway)
  train = choose_train(railway)
  unless train.has_carriages?
    puts "#{train} has no carriages"
    return
  end
  carriage = choose_from_list(train.carriages, 'carriage')[:item]
  train.remove_carriage(carriage)
end

def show_carriages_of_train(railway)
  train = choose_train(railway)
  unless train.has_carriages?
    puts "#{train} has no carriages"
    return
  end
  puts "Carriages of train #{train}:"
  show_list(train.carriages)
end


def move_train_forward(railway)
  unless railway.has_trains?
    puts NO_TRAINS_ERROR
    return
  end
  
  train = choose_from_list(railway.trains, 'train')[:item]
  unless train.on_route?
    puts "First set train #{train} on route"
    return
  end
  train_station = train.go_next_station
  if train_station
    puts "#{train} now on the station #{train_station}"
  else
    puts "#{train} is already on the end station of the route"
  end
end

def move_train_backward(railway)
  unless railway.has_trains?
    puts NO_TRAINS_ERROR
    return
  end
  
  train = choose_from_list(railway.trains, 'train')[:item]
  unless train.on_route?
    puts "First set train #{train} on route."
    return
  end
  train_station = train.go_previous_station
  if train_station
    puts "#{train} now on the station #{train_station}."
  else
    puts "#{train} is already on the start station of the route."
  end
end

def show_stations(railway)
  unless railway.has_stations?
    puts NO_STATIONS_ERROR
    return
  end
  puts 'Stations:'
  show_list(railway.stations)
end

def show_trains_on_station(railway)
  unless railway.has_trains?
    puts NO_TRAINS_ERROR
    return
  end
  unless railway.has_stations?
    puts NO_STATIONS_ERROR
    return
  end

  station = choose_from_list(railway.stations, 'station')[:item]
  unless station.has_trains?
    puts "There are no trains on station #{station}."
    return
  end
  puts "Trains on station #{station}:"
  show_list(station.trains)
end

my_railway = Railway.new

continue = true

loop do
  user_choise = choose_from_list(main_menu, 'R A I L W A Y  M A I N  M E N U')[:index]
  break if user_choise == main_menu.size - 1
  
  case user_choise
  
  when 0
    create_station(my_railway)
  
  when 1
    create_train(my_railway)

  when 2
    create_route(my_railway)

  when 3
    show_route_stations(my_railway)

  when 4
    add_station_to_route(my_railway)

  when 5
    delete_station_from_route(my_railway)

  when 6
    set_train_to_route(my_railway)

  when 7
    create_carriage(my_railway)

  when 8
    add_carriage_to_train(my_railway)

  when 9
    remove_carriage_from_train(my_railway)

  when 10
    show_carriages_of_train(my_railway)

  when 11
    move_train_forward(my_railway)

  when 12
    move_train_backward(my_railway)
    
  when 13
    show_stations(my_railway)
  
  when 14
    show_trains_on_station(my_railway)
    
  end

  puts ''
end
