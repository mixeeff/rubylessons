PASSENGER_TRAIN = 0
FREIGHT_TRAIN = 1
ADD_CARS = true
REMOVE_CARS = false

class Station
  attr_accessor :name, :trains
  
  def initialize(name)
    self.name = name
    self.trains =[]
  end
  
  def accept_train(train)
    @trains << train
  end
  
  def send_train(train)
    if trains.include?(train)
      trains.delete(train)
    else
      puts 'There is no such train'
    end
  end
  
  def report_trains(sorted = false)
    if trains.size == 0
      puts "There are no trains on station #{name}"
      return
    end
    if sorted 
      out_array = trains.sort {|a, b| a.train_type <=> b.train_type}
    else
      out_array = trains
    end
    puts "Trains on the station #{name}:"
    out_array.each do |train|
      if train.train_type == PASSENGER_TRAIN
        output_str = "Passenger "
      else
        output_str = "Freight "
      end
      output_str += "train number #{train.train_number} with "
      output_str += "#{train.number_of_cars} cars"
      puts output_str
    end
  end
end


class Train
  attr_accessor :speed, :number_of_cars, :route, :current_station_num
  attr_reader :train_type, :train_number

  def initialize(train_number, train_type, number_of_cars)
    @train_number = train_number
    @train_type = train_type
    self.number_of_cars = number_of_cars
    @speed = 0
  end
  
  def speed_up(speed = 1)
    self.speed += speed
  end

  def break
    self.speed = 0
  end

  def change_cars(add = true)
    return false unless speed == 0
    if add
      @number_of_cars += 1
    else
      @number_of_cars -= 1
    end
  end

  def set_route(route)
    self.route = route
    self.route.stations[0].accept_train(self)
    self.current_station_num = 0
  end

  def move(forward = true)
    unless route 
      puts "Train isn't on the route"
      return
    end
    start_station = route.stations[current_station_num]
    if forward && current_station_num < route.stations.size
      self.current_station_num += 1
    elsif current_station_num > 0
      self.current_station_num -= 1
    end
    end_station = route.stations[current_station_num]
    start_station.send_train(self)
    end_station.accept_train(self)
  end

  def report_stations
    unless route 
      puts "Train isn't on the route"
      return
    end
    current_station = route.stations[current_station_num]
    prev_station = route.stations[current_station_num - 1] if current_station_num > 0
    next_station = route.stations[current_station_num + 1] if current_station_num < route.stations.size
    puts "Previous station - #{prev_station.name}" if prev_station
    puts "Current station - #{current_station.name}"
    puts "Next station – #{next_station.name}" if next_station
  end  

end

class Route
  attr_accessor :stations
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
  end

  def insert_station(before_station, inserted_station)
    index = @stations.index(before_station)
    if index 
      @stations.insert(index, inserted_station)
    else
      "There is no such station"
    end
  end

  def report_route
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}"}    
  end
end


moscow = Station.new('Moscow')
piter = Station.new('St.Petersburg')
bologoe = Station.new('Bologoe')
tver = Station.new('Tver')
klin = Station.new('Klin')

route1 = Route.new(moscow, piter)
route1.insert_station(piter, bologoe)
route1.insert_station(bologoe, tver)
route1.insert_station(tver, klin)
route1.report_route

route2 = Route.new(moscow, piter)
route2.report_route

sapsan = Train.new('999', PASSENGER_TRAIN, 10)
cargo = Train.new('G56', FREIGHT_TRAIN, 35)

sapsan.set_route(route2)
cargo.set_route(route1)

cargo.change_cars(true)
puts "cargo has: #{cargo.number_of_cars} cars"

moscow.report_trains(true)

cargo.speed_up(50)
sapsan.speed_up(200)
puts "Sapsan speed is: #{sapsan.speed}"
cargo.change_cars(true)
sapsan.break
puts "Sapsan speed is: #{sapsan.speed}"
puts "cargo has: #{cargo.number_of_cars} cars"

sapsan.move(true)
cargo.move(true)
piter.report_trains(true)
klin.report_trains(true)
cargo.move(true)

sapsan.report_stations
cargo.report_stations




      








