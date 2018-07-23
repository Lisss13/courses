puts 'Добрый день'
puts 'Как вас зовут?'

name = gets.chomp

puts 'Какой ваш рост?'

height = gets.chomp

result = height.to_i - 110

if result < 0
	puts 'Ваш вес уже оптимальный'
else
	puts "#{name}, идеальный для вас вес #{result}"
end


