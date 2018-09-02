require_relative '../route/route'

class RouteMenu
  @@routes = []
  def self.select_route
    @@routes.each_with_index do |route, index|
      puts "#{index + 1}. Маршрут: #{route.stations.first} - #{route.stations.last}"
    end
  end

  def initialize
    puts '-----------'
    puts '1. Создать маршрут'
    puts '2. Добавить станцию'
    puts '3. Удалить станцию'
    puts '4. Показать список станций в маршруте'
    puts '-----------'
    puts '0. Вернуться в главное меню'
    select = gets.chomp.to_i
    case select
    when 1
      puts '-----------'
      create_route
    when 2
      puts '-----------'
      add_station
    when 3
      puts '-----------'
      delete_station
    when 4
      puts '-----------'
      show_routes
    when 0
      puts '-----------'
      main
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      initialize
    end
  end

  def create_route
    puts 'Создание маршрута:'
    puts 'Введите начальную станцию маршрута:'
    start_station = gets.chomp.to_s
    puts 'Введите конечную станцию маршрута'
    end_station = gets.chomp.to_s
    @@routes << Route.new(start_station, end_station)
    puts 'Маршрут создан!'
    initialize
  end

  def add_station
    puts 'Выберите маршрут для добавления станции:'
    RouteMenu.select_route
    select = gets.chomp.to_i
    puts 'Укажите название станции:'
    new_station = gets.chomp.to_s
    @@routes[select - 1].add_intermediate_station(new_station)
    puts 'Станция добавлена!'
    initialize
  end

  def delete_station
    puts 'Выберите маршрут для удаления станции:'
    RouteMenu.select_route
    select = gets.chomp.to_i
    puts 'Укажите название станции:'
    delete_station = gets.chomp.to_s
    @@routes[select - 1].remove_station(delete_station)
    puts 'Станция удалена!'
    initialize
  end

  def show_routes
    puts 'Выберите маршрут для показа списка станции:'
    RouteMenu.select_route
    puts '-----------'
    select = gets.chomp.to_i
    @@routes[select - 1].print_station
    initialize
  end
end
