require_relative 'train'

class PassengerTrain < Train
  def initialize(id)
    super(id, 'пассажирский')
  end

  def add_train_car(train_car)
    super if train_car.type == 'пассажирский'
  end
end
