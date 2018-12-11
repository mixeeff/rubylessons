module UserInterface
  MENU = [
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
  ].freeze

  def show_list(list, description = '')
    puts description
    list.each.with_index(1) { |object, index| puts "#{index}. #{object}" }
  end

  def choose_from_list(list, description)
    return puts 'No items' if list.size.zero?

    show_list(list, "Choose #{description}: ")
    print '>> '
    choise = gets.to_i - 1

    return if choise == -1

    return puts 'Invalid choise' if choise >= list.size

    list[choise]
  end

  def ask_user(prompt)
    print("#{prompt}: ")
    gets.chomp
  end

  def menu
    MENU.each.with_index(1) { |val, index| puts "#{index}. #{val[0]}" }
    print '>> '
    user_choice = gets.to_i - 1
    return if user_choice == MENU.size - 1

    MENU[user_choice][1]
  end
end
