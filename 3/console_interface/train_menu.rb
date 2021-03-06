require_relative '../train/passenger_train'
require_relative '../train/cargo_train'
require_relative '../train_car/freight_train_car'
require_relative '../train_car/passenger_train_car'
require_relative 'route_menu'
require_relative 'data_list'

class TrainMenu
  include DataList
  def initialize(main, store)
    @main = main
    @store = store
  end

  ##
  # menu for Router
  def menu
    puts '-----------'
    puts '1. Создать вагон'
    puts '2. Создать поезд'
    puts '3. Назначить маршрут поезду'
    puts '4. Добавить вагон поезду'
    puts '5. Отцепить вагон'
    puts '6. Переместить поезд на следующую станцию'
    puts '7. Переместить поезд на предыдущую станцию'
    puts '8. Вывести список вагонов у поезда'
    puts '9. Занять место в вагоне'
    puts '-----------'
    puts '0. Вернуться в главное меню'
    select = gets.chomp.to_i
    case select
    when 1
      puts '-----------'
      create_train_car
    when 2
      puts '-----------'
      create_train
    when 3
      puts '-----------'
      add_train_route
    when 4
      puts '-----------'
      attach_train_car
    when 5
      puts '-----------'
      remove_train_car
    when 6
      puts '-----------'
      forward_train
    when 7
      puts '-----------'
      backward_train
    when 8
      puts '-----------'
      print_train_car_list
    when 9
      puts '-----------'
      take_place_in_train_car
    when 0
      puts '-----------'
      @main.start
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      menu
    end
  end

  private

  def create_train_car
    train_car_type = train_cat_type_menu
    puts 'Указите колличество мест'
    capacity = gets.chomp
    @store[:train_cars] << train_car_type.new(capacity)
    puts 'Вагон создан!'
    menu
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def train_cat_type_menu
    puts 'Выберете тип вагона'
    puts '1. Грузовой'
    puts '2. Пассажирский'
    select = gets.chomp.to_i
    case select
    when 1 then FreightTrainCar
    when 2 then PassengerTrainCar
    end
  end

  def create_train
    train_type = train_type_menu
    begin
      puts 'Напешите номер поезда'
      number = gets.chomp
      @store[:trains] << train_type.new(number)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts 'Поезд создан!'
    menu
  end

  def train_type_menu
    puts 'Укажите тип поезда:'
    puts '1. Грузовой'
    puts '2. Пассажирский'
    select = gets.chomp.to_i
    case select
    when 1 then CargoTrain
    when 2 then PassengerTrain
    end
  end

  def add_train_route
    puts 'Выберите поезд для назначения ему маршрута:'
    select_train
    train = gets.chomp.to_i
    selected_train = @store[:trains][train - 1]
    puts 'Выберите маршрут для назначения его поезду:'
    route = gets.chomp.to_i
    selected_route = @store[:routes][route - 1]
    selected_train.itinerary(selected_route)
    puts 'Маршрут добавлен!'
    menu
  end

  def attach_train_car
    puts 'Выберите поезд для добавления вагона'
    select_train
    train = gets.chomp.to_i
    selected_train = @store[:trains][train - 1]
    puts 'Выберите тип вагона для Вашего поезда:'
    select_train_car
    train_car = gets.chomp.to_i
    selected_train_car = @store[:train_cars][train_car - 1]
    selected_train.add_train_car(selected_train_car)
    puts 'Вагон добавлен!'
    menu
  end

  def remove_train_car
    puts 'Выберите поезд для удаления вагона'
    select_train
    train = gets.chomp
    select_train_car
    train_car = gets.chomp
    @store[:trains][train - 1].remove_train_car(@store[:train_cars][train_car - 1])
    puts 'Вагон удален!'
    menu
  end

  def forward_train
    puts 'Выберите поезд для движения к следующей станции:'
    select_train
    train = gets.chomp.to_i
    selected_train = @store[:trains][train - 1]
    selected_train.go_to_next_station
    puts "Станция: #{selected_train.current_station}"
    menu
  end

  def backward_train
    puts 'Выберите поезд для движения к предыдущей станции:'
    select_train
    train = gets.chomp.to_i
    selected_train = @store[:trains][train - 1]
    selected_train.go_to_previous_station
    puts "Станция: #{selected_train.current_station}"
    menu
  end

  def print_train_car_list
    select_train
    train = gets.chomp.to_i
    @store[:trains][train - 1].each_train_car do |train_car|
      puts "#{train_car.number}, #{train_car.type}, " \
           "#{train_car.free_place} #{train_car.busy_place}"
    end
    menu
  end

  def take_place_in_train_car
    select_train_car
    train_car_index = gets.chomp.to_i
    train_car = @store[:train_cars][train_car_index - 1]
    if train_car.class == PassengerTrainCar
      train_car.take_place
    else
      puts 'Какое количество места?'
      capacity = gets.chomp.to_i
      train_car.take_place(capacity)
    end
    menu
  end
end
