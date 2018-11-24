class Railway
  TRAIN_TYPES = ['Passenger', 'Cargo']

  attr_reader :stations, :trains, :routes, :passenger_carriages, :cargo_carriages

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @passenger_carriages = []
    @cargo_carriages =[]
  end

  def has_stations?
    !@stations.empty?
  end

  def add_station(station)
    @stations << station
    station
  end

  def has_trains?
    !@trains.empty?
  end

  def add_train(train)
    @trains << train
    train
  end

  def show_trains
    puts "Trains:"
    @trains.each.with_index(1) { |train, index| puts "#{index}. #{train.number}" }
  end

  def has_routes?
    !@routes.empty?
  end

  def add_route(route)
    @routes << route
    route
  end

  def add_carriage(carriage)
    if carriage.class == Passenger_carriage
      @passenger_carriages << carriage
    elsif carriage.class == Cargo_carriage
      @cargo_carriages << carriage
    end
  end
end
