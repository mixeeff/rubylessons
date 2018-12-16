# frozen_string_literal: true

module UserInterface
  MENU = ['Create station',
          'Change station name',
          'Show station name history',
          'Create train',
          'Change train number',
          'Create carriage',
          'Create route',
          'Show route stations',
          'Exit'].freeze

  def method_name(menu_name)
    menu_name.downcase.tr(' ', '_')
  end

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
    choose_from_list(MENU, 'action')
  end
end
