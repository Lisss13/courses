require_relative '../train/passenger_train'
require_relative '../train/cargo_train'
require_relative '../train_car/train_car'
require_relative 'route_menu'

class TrainMenu
  @@train_cars = []
  @@trains = []
  def self.select_train
    @@trains.each_with_index do |train, index|
      puts "#{index + 1}. Номер поезда: #{train.id}"
    end
  end

  def self.select_train_car
    @@train_cars.each_with_index do |train_car, index|
      puts "#{index + 1}. Тип вагона: #{train_car.type}"
    end
  end

  def initialize
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
        main
      else
        puts 'Ошибка ввода, выберите доступный вариант'
        initialize
    end
  end

  def create_train_car
    puts 'Укажите тип вагона (грузовой или пассажирский)'
    train_car_type = gets.chomp.to_s
    @@train_cars << TrainCar.new(train_car_type)
    puts 'Вагон создан!'
    initialize
  end

  def create_train
    puts 'Укажите тип поезда:'
    puts '1. Грузовой'
    puts '2. Пассажирский'
    select = gets.chomp.to_i
    case select
    when 1
      puts 'Укажите номер поезда:'
      number = gets.chomp.to_i
      @@trains << CargoTrain.new(number)
    when 2
      puts 'Укажите номер поезда:'
      number = gets.chomp.to_i
      @@trains << PassengerTrain.new(number)
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      create_train
    end
    puts 'Поезд создан!'
    initialize
  end

  def add_train_route
    puts 'Выберите поезд для назначения ему маршрута:'
    TrainMenu.select_train
    train = gets.chomp.to_i
    selected_train = @@trains[train - 1]
    puts 'Выберите маршрут для назначения его поезду:'
    RouteMenu.select_route
    route = gets.chomp.to_i
    selected_route = RouteMenu.routes[route - 1]
    selected_train.itinerary(selected_route)
    puts 'Маршрут добавлен!'
    initialize
  end

  def attach_train_car
    puts 'Выберите поезд для добавления вагона'
    TrainMenu.select_train
    train = gets.chomp.to_i
    selected_train = @@trains[train - 1]
    puts 'Выберите тип вагона для Вашего поезда:'
    TrainMenu.select_train_car
    train_car = gets.chomp.to_i
    selected_train_car = @@train_cars[train_car - 1]
    selected_train.add_train_car(selected_train_car)
    puts 'Вагон добавлен!'
    initialize
  end

  def remove_train_car
    puts 'Выберите поезд для удаления вагона'
    TrainMenu.select_train
    train = gets.chomp.to_i
    TrainMenu.select_train_car
    train_car = gets.chomp.to_i
    @@trains[train - 1].remove_train_car(@@train_cars[train_car - 1])
    puts 'Вагон удален!'
    initialize
  end

  def forward_train
    puts 'Выберите поезд для движения к следующей станции:'
    TrainMenu.select_train
    train = gets.chomp.to_i
    selected_train = @@trains[train - 1]
    selected_train.go_to_next_station
    puts "Станция: #{selected_train.current_station}"
    initialize
  end

  def backward_train
    puts 'Выберите поезд для движения к предыдущей станции:'
    TrainMenu.select_train
    train = gets.chomp.to_i
    selected_train = @@trains[train - 1]
    selected_train.go_to_previous_station
    puts "Станция: #{selected_train.current_station}"
    initialize
  end
end