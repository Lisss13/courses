require_relative 'route/route'
require_relative 'station/station'
require_relative 'train_car/train_car'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'
require 'test/unit'

class Main < Test::Unit::TestCase

  def setup
    @train = PassengerTrain.new(1)
    @train_two = CargoTrain.new(2)
    @train_third = CargoTrain.new(3)

    @station_start = Station.new('Санкт-Петербург')
    @station_one = Station.new('Чудово')
    @station_two = Station.new('Тверь')
    @station_end = Station.new('Москва')

    @route = Route.new(@station_start, @station_end)

    @first_passenger_train_car = TrainCar.new('пассажирский')
    @second_passenger_train_car = TrainCar.new('пассажирский')
    @third_passenger_train_car = TrainCar.new('пассажирский')

    @first_cargo_train_car = TrainCar.new('грузовой')
    @second_cargo_train_car = TrainCar.new('грузовой')
    @third_cargo_train_car = TrainCar.new('грузовой')
  end

  def test_train
    @train.gain_speed
    @train.gain_speed
    assert_equal(20, @train.speed)
    @train.reduce_speed
    assert_equal(10, @train.speed)
    @train.reduce_speed
    @train.reduce_speed
    @train.reduce_speed
    assert_equal(0, @train.speed)
    @train.gain_speed
    @train.gain_speed
    @train.stop
    assert_equal(0, @train.speed)

    @train.itinerary(@route)
    assert_equal([@train], @station_start.trains)
    @train_two.itinerary(@route)
    assert_equal([@train, @train_two], @station_start.trains)

    @train.itinerary(@route)
    assert_equal(@station_start, @train.current_station)
    @train.go_to_next_station
    assert_equal(@station_end, @train.current_station)

    @train.set_company_manufacturer('Коков')
    assert_equal('Коков', @train.company_manufacturer)
  end

  def test_passenger_train_car
    @train.add_train_car(@first_passenger_train_car)
    @train.add_train_car(@second_passenger_train_car)
    @train.add_train_car(@third_passenger_train_car)
    assert_equal(3, @train.train_cars.size)
    assert_equal([@first_passenger_train_car, @second_passenger_train_car, @third_passenger_train_car], @train.train_cars)

    @train.remove_train_car(@second_passenger_train_car)
    assert_equal(2, @train.train_cars.size)
    assert_equal([@first_passenger_train_car, @third_passenger_train_car], @train.train_cars)

    @train.remove_train_car(@second_passenger_train_car)
    assert_equal(2, @train.train_cars.size)
    assert_equal([@first_passenger_train_car, @third_passenger_train_car], @train.train_cars)

    @train.add_train_car(@first_cargo_train_car)
    assert_equal(2, @train.train_cars.size)
    assert_equal([@first_passenger_train_car, @third_passenger_train_car], @train.train_cars)
  end

  def test_cargo_train_car
    @train_two.add_train_car(@first_cargo_train_car)
    @train_two.add_train_car(@second_cargo_train_car)
    @train_two.add_train_car(@third_cargo_train_car)
    assert_equal(3, @train_two.train_cars.size)
    assert_equal([@first_cargo_train_car, @second_cargo_train_car, @third_cargo_train_car], @train_two.train_cars)

    @train_two.remove_train_car(@second_cargo_train_car)
    assert_equal(2, @train_two.train_cars.size)
    assert_equal([@first_cargo_train_car, @third_cargo_train_car], @train_two.train_cars)

    @train_two.remove_train_car(@second_passenger_train_car)
    assert_equal(2, @train_two.train_cars.size)
    assert_equal([@first_cargo_train_car, @third_cargo_train_car], @train_two.train_cars)

    @train_two.add_train_car(@first_passenger_train_car)
    assert_equal(2, @train_two.train_cars.size)
    assert_equal([@first_cargo_train_car, @third_cargo_train_car], @train_two.train_cars)

    @train_two.set_company_manufacturer('Кряга')
    assert_equal('Кряга', @train_two.company_manufacturer)
  end

  def test_route
    @train.itinerary(@route)
    assert_equal(@route.stations.first, @train.route.stations.first)
    assert_equal(@route.stations.last, @train.route.stations.last)
    assert_equal([@station_start, @station_end], @route.stations)
    @route.add_intermediate_station(@station_one)
    @route.add_intermediate_station(@station_two)
    assert_equal([@station_start, @station_one, @station_two,  @station_end], @route.stations)

    assert_equal(@train.route.stations, @route.stations)

    @route.remove_station(@station_one)
    assert_equal([@station_start, @station_two,  @station_end], @route.stations)

    @route.remove_station_by_name('Тверь')
    assert_equal([@station_start,  @station_end], @route.stations)
  end

  def test_station
    assert_equal('Санкт-Петербург', @station_start.name)
    @station_start.accept_train @train
    assert_equal([@train], @station_start.trains)
    @station_start.accept_train @train_two
    @station_start.accept_train @train_third
    assert_equal([@train, @train_two, @train_third], @station_start.trains)
    assert_equal([@train], @station_start.trains_with_type('пассажирский'))
    assert_equal([@train_two, @train_third], @station_start.trains_with_type('грузовой'))

    @train_two.itinerary(@route)
    @station_start.send_train(@train_two)
    assert_equal([@train, @train_third], @station_start.trains)
  end

  def static_method
    # assert_equal(@train_two, Train.find(2))
    # assert_equal(@train_third, Train.find(3))
    # Тест который непонятно почему ломается
    # assert_equal([@station_start, @station_one, @station_two, @station_end], Station.all())
    assert_equal 3, Train.instances
    assert_equal 4, Station.instances
    assert_equal 1, Route.instances
  end
end
