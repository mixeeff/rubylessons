module TestRailway
  TRAIN_NOT_FOUND = 'Train not found'
  
  def create_test_objects
    
  end

  def create_test_stations
    puts 'CREATING STATIONS'
    @moscow = Station.new('Moscow')
    @tver = Station.new('Tver')
    @bologoe = Station.new('Bologoe')
    @piter = Station.new('St.Petersburg')
    @wrong_station = Station.new('Kukuevo')
     
    @my_railway.stations << @moscow
    @my_railway.stations << @tver
    @my_railway.stations << @bologoe
    @my_railway.stations << @piter
    @my_railway.stations << @wrong_station

    show_stations
    puts '-'*10
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
    
    show_trains
    puts 'Find test'
    train = Train.find('001-PS')
    puts train ? train : TRAIN_NOT_FOUND
    train = Train.find('999-PS')
    puts train ? train : TRAIN_NOT_FOUND
    puts '-'*10
  end

  def create_test_carriages
    puts 'CREATING CARRIAGES'
    @pass_carriage1 = PassengerCarriage.new('PLC001', 50)
    @pass_carriage2 = PassengerCarriage.new('CPE002', 30)
    @cargo_carriage1 = CargoCarriage.new('CRC001', 120)
    @cargo_carriage2 = CargoCarriage.new('CRC002', 75)
    
    @my_railway.passenger_carriages << @pass_carriage1
    @my_railway.passenger_carriages << @pass_carriage2
    @my_railway.cargo_carriages << @cargo_carriage1
    @my_railway.cargo_carriages << @cargo_carriage2
    
    show_list(@my_railway.passenger_carriages + @my_railway.cargo_carriages)
    puts '-'*10
  end

  def test_carriage_operations
    puts 'CARRIAGE OPERATIONS'
    @pass_train1.add_carriage(@pass_carriage1)
    @pass_train1.add_carriage(@pass_carriage2)
    @pass_train1.remove_carriage(@pass_carriage2)
    @pass_train2.add_carriage(@pass_carriage2)

    @pass_carriage1.reserve_space
    @pass_carriage1.reserve_space
    @pass_carriage2.reserve_space

    @cargo_carriage1.reserve_space(20)
    @cargo_carriage2.reserve_space(75)

    @cargo_train1.add_carriage(@cargo_carriage1)
    @cargo_train1.add_carriage(@cargo_carriage2)
    @cargo_train2.add_carriage(@cargo_carriage2)

    puts "Carriages of #{@pass_train1}:"
    show_list(@pass_train1.carriages)
    puts ''
    puts "Carriages of #{@pass_train1}:"
    show_list(@pass_train2.carriages)
    puts ''
    puts "Carriages of #{@cargo_train1}:"
    show_list(@cargo_train1.carriages)
    puts ''
    puts "Carriages of #{@cargo_train2}:"
    show_list(@cargo_train2.carriages)

    puts '-'*10
  end

  def create_test_routes
    puts 'CREATING ROUTES'
    @route1 = Route.new(@moscow, @piter)
    @my_railway.routes << @route1
    @route2 = Route.new(@moscow, @piter)
    @my_railway.routes << @route2

    @route1.add_station(@tver)
    @route1.add_station(@bologoe)
    @route1.add_station(@wrong_station)
    
    @route1.delete_station(@wrong_station)

    show_routes
    puts ''
    @route1.report
    puts ''
    @route2.report
    puts '-'*10
  end 

  def test_routes_and_trains
    def move_forward(train)
        puts "#{train} moving forward to #{train.go_next_station}"
    end

    def move_backward(train)
        puts "#{train} moving backward to #{train.go_previous_station}"
    end

    puts 'ROUTES AND TRAINS OPERATIONS'
    @pass_train1.set_route(@route1)
    @pass_train2.set_route(@route1)
    @cargo_train1.set_route(@route2)
    @cargo_train2.set_route(@route2)

    move_forward(@pass_train1)
    move_forward(@pass_train1)
    move_forward(@pass_train1)
    move_forward(@pass_train2)
    
    move_forward(@cargo_train1)
    move_forward(@cargo_train2)

    move_backward(@cargo_train2)
    
    puts ''
    puts "Trains on station #{@piter}:"
    @piter.each_train { |train| puts train }
    puts ''
    puts "Trains on station #{@moscow}:"
    @moscow.each_train { |train| puts train }
    
    puts '-'*10
  end
end
