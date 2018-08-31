require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_train_car'
require_relative 'passenger_train_car'
require_relative 'route'
require_relative 'station'


@train = PassengerTrain.new(1)
@first_passenger_train_car = PassengerTrainCar.new
@train.add_train_car(@first_passenger_train_car)
@train.add_train_car(@first_passenger_train_car)