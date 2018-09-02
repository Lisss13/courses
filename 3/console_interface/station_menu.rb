require_relative '../station/station'

class StationMenu
  @@stations = []
  def initialize
    puts '-----------'
    puts '1. Создать станцию'
    puts '2. Показать список станций'
    puts '-----------'
    puts '0. Вернуться в главное меню'
    select = gets.chomp.to_i
    case select
    when 1
      puts '-----------'
      create_station
    when 2
      puts '-----------'
      show_stations
    when 0
      puts '-----------'
      main
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      initialize
    end
  end

  def create_station
    puts 'Введите название станции:'
    station_name = gets.chomp.to_s
    @@stations << Station.new(station_name)
    puts "Станция #{station_name} создана"
    initialize
  end

  def show_stations
    puts 'Список станций:'
    @@stations.each { |station| p station.name }
    initialize
  end
end
