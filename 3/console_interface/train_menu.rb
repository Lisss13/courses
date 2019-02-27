require_relative '../train/passenger_train'
require_relative '../train/cargo_train'
require_relative '../train_car/train_car'
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
    puts 'Укажите тип вагона (грузовой или пассажирский)'
    train_car_type = gets.chomp
    @store[:train_cars] << TrainCar.new(train_car_type)
    puts 'Вагон создан!'
    menu
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    train_type = train_type_menu
    begin
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
    train = gets.chomp
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
    train = gets.chomp
    selected_train = @store[:trains][train - 1]
    puts 'Выберите тип вагона для Вашего поезда:'
    select_train_car
    train_car = gets.chomp
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
end
