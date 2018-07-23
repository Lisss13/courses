
puts 'Введите 1 сторону'
a = gets.chomp.to_f
puts 'Введите 2 сторону'
b = gets.chomp.to_f
puts 'Введите 3 сторону'
c = gets.chomp.to_f

isosceles = a == b || a == c || b == c

if c > a && c > b
	if c ** 2 == a ** 2 + b ** 2
		puts 'треугольник прямоугольный'
		puts 'треугольник равнобедренный' if isosceles
	end
elsif a > c && a > b
	if a ** 2 == c ** 2 + b ** 2
		puts 'треугольник прямоугольный'
		puts 'треугольник равнобедренный' if isosceles
	end
else
	if b ** 2 == c ** 2 + a ** 2
		puts 'треугольник прямоугольный'
		puts 'треугольник равнобедренный' if isosceles
	end
end