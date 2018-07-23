puts 'Введите коэфиценты квадратного уровнения'
puts 'ax2 + bx + c = 0'
print 'a = '
a = gets.chomp.to_f
print 'b = '
b = gets.chomp.to_f
print 'c = '
c = gets.chomp.to_f

D = (b ** 2) - (4 * a * c)
puts "D = #{D}"

if D > 0
	puts "x1 = #{(-b + Math.sqrt(D)) / (2 * a)}"
	puts "x2 = #{(-b - Math.sqrt(D)) / (2 * a)}"
elsif D == 0
	puts "x = #{-b / (2 * a)}"
else
	puts 'Корней нет'
end