require_relative 'train'

class CargoTrain < Train
  def initialize(id)
    super(id, 'пассажирский')
  end

  def add_train_car(train_car)
    super(train_car) if train_car.class.name == 'CargoTrainCar'
  end
end
