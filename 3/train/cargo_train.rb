require_relative 'train'

class CargoTrain < Train
  ##
  # @param [Number] id number or id of train
  def initialize(id)
    super(id, 'грузовой')
  end

  ##
  # Add train car to train
  # @param [TrainCar] train_car object of TrainCar
  def add_train_car(train_car)
    super if train_car.type == 'грузовой'
  end
end
