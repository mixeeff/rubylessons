puts "Решение квадратного уравнения"
puts "Введите коэффициенты:"
print "a = "
a = gets.chomp.to_i
print "b = "
b = gets.chomp.to_i
print "c = "
c = gets.chomp.to_i
disсriminant = b**2 - 4 * a * c
puts "Уравнение #{"#{a if a > 1}x**2" if a}#{"+" if b>0}#{"#{b}x" if b}#{"+" if c>0}#{"#{c}" if c} = 0 "
if disсriminant < 0
	puts "не имеет корней"
elsif disсriminant == 0
	root = -b / (2.0*a)
	puts "имеет один корень х = #{root.round(3)}"
else
	disсriminant_root = Math.sqrt(disсriminant)
	root_1 = (-b + disсriminant_root) / (2.0*a)
	root_2 = (-b - disсriminant_root) / (2.0*a)
	puts "имеет два корня:"
	puts "х1 = #{root_1.round(5)}"
	puts "х2 = #{root_2.round(5)}"
end