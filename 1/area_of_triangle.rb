puts 'Задайте основание треугольника'
a = gets.chomp
puts 'Задайте высоту треугольника'
h = gets.chomp
s = (a.to_f * h.to_f) / 2
puts "S = #{s}"