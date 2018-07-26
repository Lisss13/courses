puts 'Введите коэфиценты квадратного уровнения'
puts 'ax2 + bx + c = 0'
print 'a = '
a = gets.to_f
print 'b = '
b = gets.to_f
print 'c = '
c = gets.to_f

D = (b**2) - (4 * a * c)
puts "D = #{D}"

if D > 0
  x1 = (-b + Math.sqrt(D)) / (2 * a)
  x2 = (-b - Math.sqrt(D)) / (2 * a)
  puts "x1 = #{x1}"
	puts "x2 = #{x2}"
elsif D == 0
  x = -b / (2 * a)
	puts "x = #{x}"
else
	puts 'Корней нет'
end
