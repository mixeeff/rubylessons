require_relative('constants')

module CarriageOperations
  include Constants

  def new_pass_carriage(num)
    seats = ask_user('Enter number of seats').to_i
    carriage = PassengerCarriage.new(num, seats)
    @my_railway.passenger_carriages << carriage
    carriage
  end

  def new_cargo_carriage(num)
    volume = ask_user('Enter volume').to_i
    carriage = CargoCarriage.new(num, volume)
    @my_railway.cargo_carriages << carriage
    carriage
  end

  def create_carriage
    num = ask_user('Enter carriage number')
    type = choose_from_list(TRAIN_TYPES, "type of the carriage #{num}")
    return unless type

    carriage = if type == TRAIN_TYPES[0]
                 new_pass_carriage(num)
               else
                 new_cargo_carriage(num)
               end
    carriage.manufacturer = ask_user('Enter manufacturer (optional)')
    puts "#{carriage} created."
  end

  def select_suitable_carriage(train)
    if train.is_a?(PassengerTrain)
      carriage_list = @my_railway.passenger_carriages - train.carriages
    elsif train.is_a?(CargoTrain)
      carriage_list = @my_railway.cargo_carriages - train.carriages
    end
    if carriage_list.empty?
      puts 'There are no suitable carriages for this train.'
      return
    end
    choose_from_list(carriage_list, 'carriage')
  end

  def add_carriage_to_train
    return puts NO_TRAINS_ERROR unless @my_railway.trains?

    train = choose_train
    return unless train

    carriage = select_suitable_carriage(train)
    return unless carriage

    train.add_carriage(carriage)
    puts "#{carriage} attached to #{train}"
  end

  def remove_carriage_from_train
    train = choose_train
    return unless train
    return puts "#{train} has no carriages" unless train.carriages?

    carriage = choose_from_list(train.carriages, 'carriage')
    return unless carriage

    train.remove_carriage(carriage)
    puts "#{carriage} detached from #{train}"
  end

  def show_carriages_of_train
    train = choose_train
    return unless train
    return puts "#{train} has no carriages" unless train.carriages?

    puts "Carriages of #{train}:"
    train.each_carriage { |carriage| puts carriage }
  end

  def choose_carriage_to_reserve(type)
    train = choose_train(type)
    return unless train
    return puts "#{train} has no carriages" unless train.carriages?

    choose_from_list(train.carriages, 'carriage')
  end

  def reserve_seats
    carriage = choose_carriage_to_reserve(TRAIN_TYPES[0])
    return unless carriage

    begin
      carriage.reserve_space
    rescue RuntimeError => e
      puts e.message
    else
      puts "Reserved 1 seat in #{carriage}"
    end
  end

  def reserve_volume
    carriage = choose_carriage_to_reserve(TRAIN_TYPES[1])
    return unless carriage

    begin
      volume = ask_user('Enter volume').to_i
      carriage.reserve_space(volume)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts "Reserved #{volume} sq.meters in #{carriage}"
  end
end
