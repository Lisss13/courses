grocery_list = {}
loop do
	print 'название товара: '
	name = gets.chomp
	break if name == 'стоп'
	print 'цена: '
	price = gets.to_f
	print 'количество: '
	quantity = gets.to_i

	grocery_list[name] = {
    price: price,
		quantity: quantity
	}

end

sum = 0
puts 'Товары :'

grocery_list.each do |title, details|
	total = details[:price] * details[:quantity]
	puts "#{title} = #{total} руб."
	sum += total
end

puts "Итог: #{sum} руб."
