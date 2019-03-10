require_relative '../station/station'
require_relative 'data_list'

class StationMenu
  include DataList
  def initialize(main, store)
    @main = main
    @store = store
  end

  ##
  # menu for Router
  def menu
    puts '-----------'
    puts '1. Создать станцию'
    puts '2. Показать список станций'
    puts '3. Показать список поездов на станции'
    puts '-----------'
    puts '0. Вернуться в главное меню'
    select = gets.chomp.to_i
    case select
    when 1
      puts '-----------'
      create_station
    when 2
      puts '-----------'
      show_stations_list
    when 3
      puts '-----------'
      chow_train_in_station
    when 0
      puts '-----------'
      @main.start
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      start
    end
  end

  private

  def chow_train_in_station
    puts 'Выберите станцию'
    show_stations
    station_index = gets.chomp.to_i
    @store[:stations][station_index - 1].each_train do |train|
      p "#{train.number}, #{train.type}, #{train.train_cars.size}"
    end
    menu
  end

  def create_station
    begin
      puts 'Введите название станции:'
      station_name = gets.chomp.to_s
      @store[:stations] << Station.new(station_name)
      puts "Станция #{station_name} создана"
      menu
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  def show_stations_list
    puts 'Список станций:'
    show_stations
    menu
  end
end
