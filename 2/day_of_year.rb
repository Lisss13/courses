
day_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

print 'день: '
day = gets.to_i
print 'месяц: '
month = gets.to_i
print 'год: '
year = gets.to_i
day_number = day_of_month[0...month - 1].reduce(day, :+)

if month > 2 && year % 4 == 0
  unless year % 100 == 0 && year % 400 != 0
    p day_number + 1
    exit
	end
end

p day_number
