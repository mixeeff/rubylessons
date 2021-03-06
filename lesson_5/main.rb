require_relative('station')
require_relative('route')
require_relative('train')
require_relative('passenger_train')
require_relative('cargo_train')
require_relative('carriage')
require_relative('passenger_carriage')
require_relative('cargo_carriage')
require_relative('railway_state')

class Main
  NO_STATIONS_ERROR = 'First create at list 2 stations.'
  NO_ROUTES_ERROR = 'First create at least 1 route.'
  NO_TRAINS_ERROR = 'First create at least 1 train.'

  TRAIN_TYPES = ['Passenger', 'Cargo']

  def initialize
    @main_menu = [
      ['Create station', :create_station],
      ['Show stations', :show_stations],
      ['Show train on station', :show_trains_on_station],

      ['Create train', :create_train],
      ['Show trains', :show_trains],
      ['Find train', :find_train],
      ['Move train forward', :move_train_forward],
      ['Move train backward', :move_train_backward],
      
      ['Create carriage', :create_carriage],
      ['Add carriage to train', :add_carriage_to_train],
      ['Remove carriage from train', :remove_carriage_from_train],
      ['Show carriages of train', :show_carriages_of_train],
      
      ['Create route', :create_route],
      ['Show routes', :show_routes],
      ['Show route stations', :show_route_stations],
      ['Add station to route', :add_station_to_route],
      ['Delete station from route', :delete_station_from_route],
      ['Set train to route', :set_train_to_route],
      
      ['Quit', :exit]
    ]
    @my_railway = RailwayState.new
  end

  # User Interface methods

  def show_list(list)
    list.each.with_index(1) { |object, index| puts "#{index}. #{object}" }
  end

  def choose_from_list(list, description)
    return puts 'No items' if list.size.zero?
    puts "Choose #{description}: "
    show_list(list)
    print '>> '
    choise = gets.to_i - 1
    return if choise == -1
    if choise >= list.size
      puts 'Invalid choise'
      return
    else
      list[choise]
    end
  end

  def choose_route
    choose_from_list(@my_railway.routes, 'route')
  end

  def choose_train
    choose_from_list(@my_railway.trains, 'train')
  end

  # Station methods

  def create_station
    print 'Enter station name: '
    station_name = gets.chomp.capitalize
    return if station_name.empty?
    station = Station.new(station_name)
    @my_railway.stations << station
    puts "Station #{station} created"
  end

  def show_stations
    return puts NO_STATIONS_ERROR unless @my_railway.has_stations?
    puts 'Stations:'
    show_list(@my_railway.stations)
    puts "total #{Station.instances} stations"
  end

  def show_trains_on_station
    return puts NO_TRAINS_ERROR unless @my_railway.has_trains?
    return puts NO_STATIONS_ERROR unless @my_railway.has_stations?
    
    station = choose_from_list(@my_railway.stations, 'station')
    return unless station
    return puts "There are no trains on station #{station}." unless station.has_trains?
    
    puts "Trains on station #{station}:"
    show_list(station.trains)
  end

  # Train methods

  def create_train
    print 'Enter train number: '
    train_number = gets.chomp
    return if train_number.empty?
    train_type = choose_from_list(TRAIN_TYPES, "type of the train #{train_number}")
    return unless train_type
    if train_type == TRAIN_TYPES[0]
      train = PassengerTrain.new(train_number)
    elsif train_type == TRAIN_TYPES[1]
      train = CargoTrain.new(train_number)
    end
    print 'Enter manufacturer (optional): '
    manufacturer = gets.chomp
    train.manufacturer = manufacturer unless manufacturer.empty?
    @my_railway.trains << train
    puts "#{train} created."
  end

  def show_trains
    return puts NO_TRAINS_ERROR unless @my_railway.has_trains?
    puts 'Trains:'
    show_list(@my_railway.trains)
    puts "total #{PassengerTrain.instances + CargoTrain.instances} trains"
  end

  def find_train
    print 'Enter train number: '
    number = gets.chomp
    train = Train.find(number)
    return puts 'No trains with this number' unless train
    puts train
  end

  def move_train_forward
    return puts NO_TRAINS_ERROR unless @my_railway.has_trains?
    
    train = choose_train
    return unless train
    return puts "First set train #{train} on route" unless train.on_route?
    
    train_station = train.go_next_station
    if train_station
      puts "#{train} now on the station #{train_station}"
    else
      puts "#{train} is already on the end station of the route"
    end
  end

  def move_train_backward
    return puts NO_TRAINS_ERROR unless @my_railway.has_trains?
    
    train = choose_train
    return unless train
    return puts "First set train #{train} on route." unless train.on_route?
    
    train_station = train.go_previous_station
    if train_station
      puts "#{train} now on the station #{train_station}."
    else
      puts "#{train} is already on the start station of the route."
    end
  end

  # Carriage methods

  def create_carriage
    print 'Enter carriage number: '
    carriage_number = gets.chomp
    return if carriage_number.empty?
    carriage_type = choose_from_list(TRAIN_TYPES, "type of the carriage #{carriage_number}")
    return unless carriage_type
    if carriage_type == TRAIN_TYPES[0]
      carriage = PassengerCarriage.new(carriage_number)
      @my_railway.passenger_carriages << carriage
    elsif carriage_type == TRAIN_TYPES[1]
      carriage = CargoCarriage.new(carriage_number)
      @my_railway.cargo_carriages << carriage
    end
    print 'Enter manufacturer (optional): '
    manufacturer = gets.chomp
    carriage.manufacturer = manufacturer unless manufacturer.empty?
    puts "#{carriage} created."
  end

  def add_carriage_to_train
    return puts NO_TRAINS_ERROR unless @my_railway.has_trains?
    train = choose_train
    return unless train
    if train.is_a?(PassengerTrain)
      carriage_list = @my_railway.passenger_carriages - train.carriages
    elsif train.is_a?(CargoTrain)
      carriage_list = @my_railway.cargo_carriages - train.carriages
    end
    if carriage_list.empty?
      puts 'There are no suitable carriages for this train.'
      return
    end
    carriage = choose_from_list(carriage_list, 'carriage')
    return unless carriage
    train.add_carriage(carriage)
    puts "#{carriage} attached to #{train}"
  end

  def remove_carriage_from_train
    train = choose_train
    return unless train
    return puts "#{train} has no carriages" unless train.has_carriages?
    
    carriage = choose_from_list(train.carriages, 'carriage')
    return unless carriage
    train.remove_carriage(carriage)
    puts "#{carriage} detached from #{train}"
  end

  def show_carriages_of_train
    train = choose_train
    return unless train
    return puts "#{train} has no carriages" unless train.has_carriages?
    
    puts "Carriages of train #{train}:"
    show_list(train.carriages)
  end

  # Route methods

  def create_route
    if Station.instances < 2
      puts NO_STATIONS_ERROR
    else
      start_station = choose_from_list(@my_railway.stations, 'start station')
      return unless start_station
      end_station_list = @my_railway.stations - [start_station]
      end_station = choose_from_list(end_station_list, 'end station')
      return unless end_station
      route = Route.new(start_station, end_station)
      @my_railway.routes << route
      puts "Route #{route} created."
    end
  end

  def show_routes
    return puts NO_ROUTES_ERROR unless @my_railway.has_routes?
    puts 'Routes:'
    show_list(@my_railway.routes)
    puts "total #{Route.instances} routes"
  end

  def show_route_stations
    return puts NO_ROUTES_ERROR unless @my_railway.has_routes?
    route = choose_route
    return unless route
    route.report
  end

  def add_station_to_route
    return puts NO_ROUTES_ERROR unless @my_railway.has_routes?
    return puts NO_STATIONS_ERROR unless @my_railway.has_stations?
    
    route = choose_route
    return unless route
    adding_stations = @my_railway.stations - route.stations
    if adding_stations.size.zero?
      puts "There are no stations to add to route #{route}"
    else
      station = choose_from_list(adding_stations, 'station to add')
      return unless station
      route.add_station(station)
      route.report
    end
  end

  def delete_station_from_route
    return puts NO_ROUTES_ERROR unless @my_railway.has_routes?
    
    route = choose_route
    return unless route
    if route.stations.size > 2
      station = choose_from_list(route.stations, 'station to delete')
      return unless station
      route.delete_station(station)
      route.report
    else
      puts 'This route has only 2 stations. It cannot be deleted'
    end
  end

  def set_train_to_route
    return puts NO_TRAINS_ERROR unless @my_railway.has_trains?
    return puts NO_ROUTES_ERROR unless @my_railway.has_routes?
    
    train = choose_train
    return unless train
    route = choose_route
    return unless route
    train.set_route(route)
    puts ("#{train} now on the route #{route} on station #{train.current_station}")
  end

  def run
    loop do
      @main_menu.each.with_index(1) {|val, index| puts "#{index}. #{val[0]}"}
      print '>> '
      user_choise = gets.to_i - 1
      send @main_menu[user_choise][1]
      break if user_choise == @main_menu.size - 1
      puts ''
    end
  end
end #class main

my_app = Main.new
my_app.run
