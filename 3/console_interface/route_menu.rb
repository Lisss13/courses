require_relative '../route/route'
require_relative 'data_list'

class RouteMenu
  include DataList
  def initialize(main, store)
    @main = main
    @store = store
  end

  ##
  # menu for Router
  def menu
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
      @main.start
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      menu
    end
  end

  private
    def create_route
      begin
        puts 'Создание маршрута:'
        puts 'Введите начальную станцию маршрута:'
        start_station = gets.chomp.to_s
        puts 'Введите конечную станцию маршрута'
        end_station = gets.chomp.to_s
        @store[:routes] << Route.new(Station.new(start_station), Station.new(end_station))
        puts 'Маршрут создан!'
        menu
      rescue RuntimeError => e
        puts e.message
        retry
      end
    end

    def add_station
      begin
        puts 'Выберите маршрут для добавления станции:'
        select_route
        select = gets.chomp.to_i
        puts 'Укажите название станции:'
        new_station = gets.chomp.to_s
        @store[:routes][select - 1].add_intermediate_station(Station.new(new_station))
        puts 'Станция добавлена!'
        menu
      rescue RuntimeError => e
        puts e.message
        retry
      end
    end

    def delete_station
      puts 'Выберите маршрут для удаления станции:'
      select_route
      select = gets.chomp.to_i
      current_route = @store[:routes][select - 1]
      puts 'Выбирите название станции'
      current_route.print_station
      delete_station_name = gets.chomp.to_s
      current_route.remove_station_by_name(delete_station_name)
      puts 'Станция удалена!'
      menu
    end

    def show_routes
      puts 'Выберите маршрут для показа списка станции:'
      select_route
      puts '-----------'
      select = gets.chomp.to_i
      @store[:routes][select - 1].print_station
      menu
    end
end
