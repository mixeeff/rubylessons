day_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
puts 'Введите дату'
print 'число: '
day = gets.to_i
print 'месяц (цифрой): '
month = gets.to_i - 1
print 'год: '
year = gets.to_i

leap_year = year % 4 == 0 && year % 100 != 0
leap_year ||= year % 400 == 0
day_in_months[1] = 29 if leap_year

days_from_start = day + day_in_months.take(month).sum
puts "#{days_from_start}-й день с начала года"
