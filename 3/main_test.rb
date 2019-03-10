require_relative 'route/route'
require_relative 'station/station'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'
require_relative 'train_car/freight_train_car'
require_relative 'train_car/passenger_train_car'

require 'test/unit'

class Main < Test::Unit::TestCase

  def setup
    @train = PassengerTrain.new('fff-22')
    @train_two = CargoTrain.new('222-34')
    @train_third = CargoTrain.new('3d3-ee')

    @station_start = Station.new('Санкт-Петербург')
    @station_one = Station.new('Чудово')
    @station_two = Station.new('Тверь')
    @station_end = Station.new('Москва')

    @route = Route.new(@station_start, @station_end)

    @first_passenger_train_car = PassengerTrainCar.new(100)
    @second_passenger_train_car = PassengerTrainCar.new(233)
    @third_passenger_train_car = PassengerTrainCar.new(43)

    @first_cargo_train_car = FreightTrainCar.new(1000)
    @second_cargo_train_car = FreightTrainCar.new(1500)
    @third_cargo_train_car = FreightTrainCar.new(25000)
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

    array_of_train_car = []
    @train.each_train_car { |train_car| array_of_train_car << train_car }
    assert_equal([@first_passenger_train_car, @third_passenger_train_car], array_of_train_car)
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

    trains = []
    @station_start.each_train { |train| trains << train }
    assert_equal([@train, @train_third], trains)
  end

  def static_method
    assert_equal 3, Train.instances
    assert_equal 4, Station.instances
    assert_equal 1, Route.instances
  end

  def test_error
    exception = assert_raise(RuntimeError) {  PassengerTrain.new('ID поезда не может быть пустым') }
    assert_equal("Неправильный формат идентификатора поезда", exception.message)
    exception = assert_raise(RuntimeError) {  PassengerTrain.new('fff-4') }
    assert_equal("Неправильный формат идентификатора поезда", exception.message)
    exception = assert_raise(RuntimeError) {  CargoTrain.new('ID поезда не может быть пустым') }
    assert_equal("Неправильный формат идентификатора поезда", exception.message)
    exception = assert_raise(RuntimeError) {  CargoTrain.new('fff-4') }
    assert_equal("Неправильный формат идентификатора поезда", exception.message)
    exception = assert_raise(RuntimeError) {  Train.new('ID поезда не может быть пустым', 'sdf') }
    assert_equal("Неправильный формат идентификатора поезда", exception.message)
    exception = assert_raise(RuntimeError) {  Train.new('fff-4', 'sdf') }
    assert_equal("Неправильный формат идентификатора поезда", exception.message)
    exception = assert_raise(RuntimeError) {  Train.new('fff---43', 'sdf') }
    assert_equal("Неправильный формат идентификатора поезда", exception.message)
  end

  def test_train_car
    @first_passenger_train_car.take_place
    assert_equal(99, @first_passenger_train_car.free_place)
    assert_equal(1, @first_passenger_train_car.busy_place)

    @first_cargo_train_car.take_place(300)
    assert_equal(700, @first_cargo_train_car.free_place)
    assert_equal(300, @first_cargo_train_car.busy_place)
  end
end
