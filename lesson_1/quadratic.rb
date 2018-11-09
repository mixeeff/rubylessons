puts "Решение квадратного уравнения"
puts "Введите коэффициенты:"
print "a = "
a = gets.to_f
print "b = "
b = gets.to_f
print "c = "
c = gets.to_f
if a == 0
  puts "Если коэффициент а=0 - это не квадратное уравнение"
  exit
end
disсriminant = b**2 - 4 * a * c
#формирование строки вывода
equation_parts = ["Уравнение "]
equation_parts << a if (a != 1) && (a != 0)
equation_parts << "x^2" unless a == 0
equation_parts << "+" if b > 0
equation_parts << b if (b != 1) && (b != 0)
equation_parts << "x" unless b == 0
equation_parts << "+" if c > 0
equation_parts << c unless c == 0
equation_parts << " = 0"
equation_str = equation_parts.join
#вывод уравнения
puts equation_str
#вывод решения
if disсriminant < 0
  puts "не имеет корней"
elsif disсriminant == 0
  root = -b / (2.0 * a)
  puts "имеет один корень х = #{root.round(3)}"
else
  disсriminant_root = Math.sqrt(disсriminant)
  root_1 = (-b + disсriminant_root) / (2.0 * a)
  root_2 = (-b - disсriminant_root) / (2.0 * a)
  puts "имеет два корня:"
  puts "х1 = #{root_1.round(5)}"
  puts "х2 = #{root_2.round(5)}"
end
