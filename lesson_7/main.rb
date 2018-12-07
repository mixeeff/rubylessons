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
  TRAIN_NOT_FOUND = 'Train not found'

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
      ['Reserve seats', :reserve_seats],
      ['Reserve volume', :reserve_volume],
      
      ['Create route', :create_route],
      ['Show routes', :show_routes],
      ['Show route stations', :show_route_stations],
      ['Add station to route', :add_station_to_route],
      ['Delete station from route', :delete_station_from_route],
      ['Set train to route', :set_train_to_route],

      ['Test railway', :test_railway],
      
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
    #return if station_name.empty?
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
    station.each_train { |train| puts train }
  end

  # Train methods

  def create_train
    begin
      print 'Enter train number: '
      train_number = gets.chomp
      train_type = choose_from_list(TRAIN_TYPES, "type of the train #{train_number}")
      return unless train_type
    
      if train_type == TRAIN_TYPES[0]
        train = PassengerTrain.new(train_number)
      elsif train_type == TRAIN_TYPES[1]
        train = CargoTrain.new(train_number)
      end
    rescue RuntimeError => e
      puts e.message
      retry
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
    return puts TRAIN_NOT_FOUND unless train
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
    carriage_type = choose_from_list(TRAIN_TYPES, "type of the carriage #{carriage_number}")
    return unless carriage_type
    if carriage_type == TRAIN_TYPES[0]
      print 'Enter number of seats: '
      seats = gets.to_i
      carriage = PassengerCarriage.new(carriage_number, seats)
      @my_railway.passenger_carriages << carriage
    elsif carriage_type == TRAIN_TYPES[1]
      print 'Enter volume: '
      volume = gets.to_i
      carriage = CargoCarriage.new(carriage_number, volume)
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
    
    puts "Carriages of #{train}:"
    train.each_carriage { |carriage| puts carriage }
  end

  def reserve_seats
    train_list = @my_railway.trains.select { |train| train.is_a? PassengerTrain }
    train = choose_from_list(train_list, 'train')
    return unless train
    carriage = choose_from_list(train.carriages, 'carriage')
    return unless carriage
    return puts "No free volume in this carriage" if carriage.free_space <= 0
    carriage.reserve_space
    puts "Reserved 1 seat in #{carriage}"
  end

  def reserve_volume
    train_list = @my_railway.trains.select { |train| train.is_a? CargoTrain }
    train = choose_from_list(train_list, 'train')
    return unless train
    carriage = choose_from_list(train.carriages, 'carriage')
    return unless carriage
    return puts "No free volume in this carriage" if carriage.free_space <= 0
    print 'Enter volume: '
    volume = gets.to_i
    carriage.reserve_space(volume)
    puts "Reserved #{volume} sq.meters in #{carriage}"
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
    puts route
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

  def test_railway
    puts 'Start test'
    puts '-'*10
    # Create Stations
    station1 = Station.new('Moscow')
    @my_railway.stations << station1
    station2 = Station.new('Tver')
    @my_railway.stations << station2
    station3 = Station.new('Bologoe')
    @my_railway.stations << station3
    station4 = Station.new('St.Petersburg')
    @my_railway.stations << station4
    wrong_station = Station.new('Kukuevo')
    @my_railway.stations << wrong_station
    show_stations
    puts ''

    # Create Trains
    pass_train1 = PassengerTrain.new('001-PS')
    @my_railway.trains << pass_train1
    pass_train2 = PassengerTrain.new('002-PS')
    @my_railway.trains << pass_train2
    cargo_train1 = CargoTrain.new('003-CR')
    @my_railway.trains << cargo_train1
    cargo_train2 = CargoTrain.new('004-CR')
    @my_railway.trains << cargo_train2
    show_trains
    puts 'Find test'
    train = Train.find('001-PS')
    puts train ? train : TRAIN_NOT_FOUND
    train = Train.find('999-PS')
    puts train ? train : TRAIN_NOT_FOUND
    puts ''

    #Create carriages
    pass_carriage1 = PassengerCarriage.new('PLC001', 50)
    @my_railway.passenger_carriages << pass_carriage1
    pass_carriage2 = PassengerCarriage.new('CPE002', 30)
    @my_railway.passenger_carriages << pass_carriage2
    cargo_carriage1 = CargoCarriage.new('CRC001', 120)
    @my_railway.cargo_carriages << cargo_carriage1
    cargo_carriage2 = CargoCarriage.new('CRC002', 75)
    @my_railway.cargo_carriages << cargo_carriage2

    #Carriage operations
    pass_train1.add_carriage(pass_carriage1)
    pass_train1.add_carriage(pass_carriage2)
    pass_train1.remove_carriage(pass_carriage2)
    pass_train2.add_carriage(pass_carriage2)

    pass_carriage1.reserve_space
    pass_carriage1.reserve_space
    pass_carriage2.reserve_space

    cargo_carriage1.reserve_space(20)
    cargo_carriage2.reserve_space(75)

    cargo_train1.add_carriage(cargo_carriage1)
    cargo_train1.add_carriage(cargo_carriage2)
    cargo_train2.add_carriage(cargo_carriage2)
    
    puts "Carriages of #{pass_train1}:"
    show_list(pass_train1.carriages)
    puts "Carriages of #{pass_train1}:"
    show_list(pass_train2.carriages)

    puts "Carriages of #{cargo_train1}:"
    show_list(cargo_train1.carriages)
    puts "Carriages of #{cargo_train2}:"
    show_list(cargo_train2.carriages)
    puts ''

    #Create routes
    route1 = Route.new(station1, station4)
    @my_railway.routes << route1
    route2 = Route.new(station1, station4)
    @my_railway.routes << route2

    #Route operations
    route1.add_station(station2)
    route1.add_station(station3)
    route1.add_station(wrong_station)
    show_routes
    puts "#{route1} after insertion 3 stations"
    route1.report
    route1.delete_station(wrong_station)
    puts "#{route1} after deletion wrong station"

    route1.report
    route2.report

    pass_train1.set_route(route1)
    pass_train2.set_route(route1)
    cargo_train1.set_route(route2)
    cargo_train1.set_route(route2)

    pass_train1.go_next_station
    pass_train1.go_next_station
    pass_train1.go_next_station
    pass_train1.go_next_station

    pass_train2.go_next_station
    cargo_train1.go_next_station
    cargo_train2.go_next_station
    cargo_train2.go_previous_station

    puts ''
    puts "Trains on station #{station4}:"
    station4.each_train { |train| puts train }
    puts ''
    puts 'Test done'
    puts '-'*10
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
