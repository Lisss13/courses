require_relative 'train'

class CargoTrain < Train
  def initialize(id)
    super(id, 'грузовой')
  end

  def add_train_car(train_car)
    super if train_car.type == 'грузовой'
  end
end
