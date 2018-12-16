# frozen_string_literal: true

require_relative('constants')

module TrainOperations
  include Constants

  def new_train
    type = choose_from_list(TRAIN_TYPES, 'type of train')
    begin
      num = ask_user('Enter train number (DDD-AA)')
      return unless type

      type == TRAIN_TYPES[0] ? PassengerTrain.new(num) : CargoTrain.new(num)
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  def create_train
    train = new_train
    @my_railway.trains << train
    puts "#{train} created."
  end

  def change_train_number
    return puts NO_TRAINS_ERROR unless @my_railway.trains?

    train = choose_from_list(@my_railway.trains, 'train')
    return unless train

    loop do
      train.number = ask_user('new number')
      break if train.valid?

      puts 'Number is not valid'
    end
    puts 'Train number changed'
  end
end
