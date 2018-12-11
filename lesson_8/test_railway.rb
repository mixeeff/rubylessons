module TestRailway
  TRAIN_NOT_FOUND = 'Train not found'.freeze

  def create_test_stations
    puts 'CREATING STATIONS'
    @moscow = Station.new('Moscow')
    @bologoe = Station.new('Bologoe')
    @piter = Station.new('St.Petersburg')
    @wrong_station = Station.new('Kukuevo')

    @my_railway.stations += [@moscow, @tver, @bologoe, @piter, @wrong_station]
  end

  def create_test_trains
    puts 'CREATING TRAINS'
    @pass_train1 = PassengerTrain.new('001-PS')
    @pass_train2 = PassengerTrain.new('002-PS')
    @cargo_train1 = CargoTrain.new('003-CR')
    @cargo_train2 = CargoTrain.new('004-CR')

    @my_railway.trains << @pass_train1
    @my_railway.trains << @pass_train2
    @my_railway.trains << @cargo_train1
    @my_railway.trains << @cargo_train2
  end

  def create_test_carriages
    puts 'CREATING CARRIAGES'
    @pass_carriage1 = PassengerCarriage.new('PLC001', 50)
    @cargo_carriage1 = CargoCarriage.new('CRC001', 120)

    @my_railway.passenger_carriages << @pass_carriage1
    @my_railway.cargo_carriages << @cargo_carriage1

    show_list(@my_railway.passenger_carriages + @my_railway.cargo_carriages)
  end

  def test_carriage_operations
    puts 'CARRIAGE OPERATIONS'
    @pass_train1.add_carriage(@pass_carriage1)
    @pass_train1.remove_carriage(@pass_carriage1)
    @pass_train2.add_carriage(@pass_carriage1)
    @cargo_train1.add_carriage(@cargo_carriage1)

    @my_railway.trains.each do |train|
      puts "Carriages of #{train}:"
      train.each_carriage { |carriage| puts carriage }
    end
  end

  def test_carriage_space
    @pass_carriage1.reserve_space
    @cargo_carriage1.reserve_space(20)
  end

  def create_test_routes
    puts 'CREATING ROUTES'
    @route1 = Route.new(@moscow, @piter)
    @my_railway.routes << @route1
    @route2 = Route.new(@moscow, @piter)
    @my_railway.routes << @route2
  end

  def test_route_operations
    @route1.add_station(@bologoe)
    @route1.add_station(@wrong_station)
    @route1.delete_station(@wrong_station)
    @route1.report
    @route2.report
  end

  def move_forward_test(train)
    puts "#{train} moving forward to #{train.go_next_station}"
  end

  def move_backward_test(train)
    puts "#{train} moving backward to #{train.go_previous_station}"
  end

  def test_routes_and_trains
    puts 'ROUTES AND TRAINS OPERATIONS'
    @pass_train1.to_route(@route1)
    @pass_train2.to_route(@route1)
    @cargo_train1.to_route(@route2)
    @cargo_train2.to_route(@route2)

    3.times { move_forward_test(@pass_train1) }
    move_forward_test(@pass_train2)

    move_forward_test(@cargo_train1)
    move_backward_test(@cargo_train1)
  end

  def trains_on_station_test
    puts "Trains on station #{@piter}:"
    @piter.each_train { |train| puts train }
    puts "Trains on station #{@moscow}:"
    @moscow.each_train { |train| puts train }
  end

  def test_stations
    create_test_stations
    show_stations
  end

  def test_trains
    create_test_trains
    show_trains
  end

  def test_carriages
    create_test_carriages
    test_carriage_operations
    test_carriage_space
  end

  def test_routes
    create_test_routes
    show_routes
    test_route_operations
    test_routes_and_trains
  end
end
