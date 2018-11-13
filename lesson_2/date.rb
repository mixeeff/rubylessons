day_in_months = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
puts "Введите дату"
print "число: "
day = gets.to_i
print "месяц (цифрой): "
month = gets.to_i
print "год: "
year = gets.to_i

leap_year = (year % 4 == 0) && (year % 100 != 0)
leap_year = true if (year % 400 == 0)
day_in_months[2] = 29 if leap_year

days_from_start = 0
month.times { |i| days_from_start += day_in_months[i] }
days_from_start += day
puts "#{days_from_start}-й день с начала года"
