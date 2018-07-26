
puts 'Введите 1 сторону'
a = gets.to_f
puts 'Введите 2 сторону'
b = gets.to_f
puts 'Введите 3 сторону'
c = gets.to_f

arr = [a, b, c].sort

if arr[2]**2 == arr[1]**2 + arr[0]**2
  puts 'треугольник прямоугольный'
  puts 'треугольник равнобедренный' if a == b || a == c || b == c
end
