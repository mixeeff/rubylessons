print "Как вас зовут? "
name = gets.chomp
print "Ваш рост в см? "
height = gets.chomp.to_i
ideal_weight = height - 110
if ideal_weight <= 0
	puts "#{name}, Ваш вес уже оптимальный"
else
	puts "#{name}, Ваш идеальный вес - #{ideal_weight} кг"
end