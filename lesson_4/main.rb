require_relative('station')
require_relative('route')
require_relative('train')
require_relative('passenger_train')
require_relative('cargo_train')
require_relative('carriage')
require_relative('railway')

class Main
  NO_STATIONS_ERROR = 'First create at list 2 stations.'
  NO_ROUTES_ERROR = 'First create at least 1 route.'
  NO_TRAINS_ERROR = 'First create at least 1 train.'

  def initialize(railway)
    @railway = railway
    @main_menu = [
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
  end

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
    choose_from_list(@railway.routes, 'route')
  end

  def choose_train
    choose_from_list(@railway.trains, 'train')
  end

  def create_station
    print 'Enter station name: '
    station_name = gets.chomp.capitalize
    return if station_name.empty?
    station = Station.new(station_name)
    @railway.add_station(station)
    puts "Station #{station} created"
  end

  def create_train
    print 'Enter train number: '
    train_number = gets.chomp
    return if train_number.empty?
    train_type = choose_from_list(Railway::TRAIN_TYPES, "type of the train #{train_number}")
    return unless train_type
    if train_type == Railway::TRAIN_TYPES[0]
      train = PassengerTrain.new(train_number)
    elsif train_type == Railway::TRAIN_TYPES[1]
      train = CargoTrain.new(train_number)
    end
    @railway.add_train(train)
    puts "#{train} created."
  end

  def create_route
    if @railway.stations.size < 2
      puts NO_STATIONS_ERROR
    else
      start_station = choose_from_list(@railway.stations, 'start station')
      return unless start_station
      end_station_list = @railway.stations - [start_station]
      end_station = choose_from_list(end_station_list, 'end station')
      return unless end_station
      route = Route.new(start_station, end_station)
      @railway.add_route(route)
      puts "Route #{route} created."
    end
  end

  def show_route_stations
    return puts NO_ROUTES_ERROR unless @railway.has_routes?
    route = choose_route
    return unless route
    route.report
  end

  def add_station_to_route
    return puts NO_ROUTES_ERROR unless @railway.has_routes?
    return puts NO_STATIONS_ERROR unless @railway.has_stations?
    
    route = choose_route
    return unless route
    adding_stations = @railway.stations - route.stations
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
    return puts NO_ROUTES_ERROR unless @railway.has_routes?
    
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
    return puts NO_TRAINS_ERROR unless @railway.has_trains?
    return puts NO_ROUTES_ERROR unless @railway.has_routes?
    
    train = choose_train
    return unless train
    route = choose_route
    return unless route
    train.set_route(route)
    puts ("#{train} now on the route #{route} on station #{train.current_station}")
  end

  def create_carriage
    print 'Enter carriage number: '
    carriage_number = gets.chomp
    return if carriage_number.empty?
    carriage_type = choose_from_list(Railway::TRAIN_TYPES, "type of the carriage #{carriage_number}")
    return unless carriage_type
    if carriage_type == Railway::TRAIN_TYPES[0]
      carriage = PassengerCarriage.new(carriage_number)
    elsif carriage_type == Railway::TRAIN_TYPES[1]
      carriage = CargoCarriage.new(carriage_number)
    end
    @railway.add_carriage(carriage)
    puts "#{carriage} created."
  end

  def add_carriage_to_train
    return puts NO_TRAINS_ERROR unless @railway.has_trains?
    
    train = choose_train
    return unless train
    if train.is_a?(PassengerTrain)
      carriage_list = @railway.passenger_carriages - train.carriages
    elsif train.is_a?(CargoTrain)
      carriage_list = @railway.cargo_carriages - train.carriages
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


  def move_train_forward
    return puts NO_TRAINS_ERROR unless @railway.has_trains?
    
    train = choose_from_list(@railway.trains, 'train')
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
    return puts NO_TRAINS_ERROR unless @railway.has_trains?
    
    train = choose_from_list(@railway.trains, 'train')
    return unless train
    return puts "First set train #{train} on route." unless train.on_route?
    
    train_station = train.go_previous_station
    if train_station
      puts "#{train} now on the station #{train_station}."
    else
      puts "#{train} is already on the start station of the route."
    end
  end

  def show_stations
    return puts NO_STATIONS_ERROR unless @railway.has_stations?
    
    puts 'Stations:'
    show_list(@railway.stations)
  end

  def show_trains_on_station
    return puts NO_TRAINS_ERROR unless @railway.has_trains?
    return puts NO_STATIONS_ERROR unless @railway.has_stations?
    
    station = choose_from_list(@railway.stations, 'station')
    return unless station
    return puts "There are no trains on station #{station}." unless station.has_trains?
    
    puts "Trains on station #{station}:"
    show_list(station.trains)
  end

  def run
    loop do
      user_choise = choose_from_list(@main_menu, 'R A I L W A Y  M A I N  M E N U')
      user_choise = @main_menu.index(user_choise)
      break if user_choise == @main_menu.size - 1
      
      case user_choise
        when 0 then create_station
        when 1 then create_train
        when 2 then create_route
        when 3 then show_route_stations
        when 4 then add_station_to_route
        when 5 then delete_station_from_route
        when 6 then set_train_to_route
        when 7 then create_carriage
        when 8 then add_carriage_to_train
        when 9 then remove_carriage_from_train
        when 10 then show_carriages_of_train
        when 11 then move_train_forward
        when 12 then move_train_backward
        when 13 then show_stations
        when 14 then show_trains_on_station
      end

      puts ''
    end
  end
end #class main

my_railway = Railway.new
my_app = Main.new(my_railway)
my_app.run
