require_relative 'train'

class PassengerTrain < Train
  def initialize(id)
    super(id, 'грузовой')
  end

  def add_train_car(train_car)
    super if train_car.class.name == 'PassengerTrainCar'
  end
end
