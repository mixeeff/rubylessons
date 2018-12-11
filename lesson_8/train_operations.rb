require_relative('constants')

module TrainOperations
  include Constants

  def new_train
    begin
        num = ask_user('Enter train number')
        type = choose_from_list(TRAIN_TYPES, "type for train #{num}")
        return unless type

        type == TRAIN_TYPES[0] ? PassengerTrain.new(num) : CargoTrain.new(num)
      end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    train = new_train
    manufacturer = ask_user('Enter manufacturer (optional)')
    train.manufacturer = manufacturer unless manufacturer.empty?
    @my_railway.trains << train
    puts "#{train} created."
  end

  def show_trains
    return puts NO_TRAINS_ERROR unless @my_railway.trains?

    show_list(@my_railway.trains, 'Trains:')
    puts "total #{PassengerTrain.instances + CargoTrain.instances} trains"
  end

  def find_train
    print 'Enter train number: '
    number = gets.chomp
    train = PassengerTrain.find(number) || CargoTrain.find(number)

    return puts TRAIN_NOT_FOUND unless train

    puts train
  end

  def move_train_forward
    return puts NO_TRAINS_ERROR unless @my_railway.trains?

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
    return puts NO_TRAINS_ERROR unless @my_railway.trains?

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
end
