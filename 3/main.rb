require_relative 'console_interface/station_menu'
require_relative 'console_interface/route_menu'
require_relative 'console_interface/train_menu'

puts 'Управление железнодорожным движением!'

def main
  puts '1. Меню станций'
  puts '2. Меню маршрутов'
  puts '3. Меню поездов'
  puts '-----------'
  puts '0. Выход из программы'

  select = gets.chomp.to_i
  case select
    when 1
      StationMenu.new
    when 2
      RouteMenu.new
    when 3
      TrainMenu.new
    when 0
      abort('Выход!')
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      puts '-----------'
      main
  end
end

main
