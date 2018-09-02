require_relative 'train'

class PassengerTrain < Train
  ##
  # @param [Number] id number or id of train
  def initialize(id)
    super(id, 'пассажирский')
  end

  ##
  # Add train car to train
  # @param [TrainCar] train_car object of TrainCar
  def add_train_car(train_car)
    super if train_car.type == 'пассажирский'
  end
end
