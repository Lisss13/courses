require_relative 'train_car'

class PassengerTrainCar < TrainCar
  def initialize(capacity)
    super('пассажирский', capacity)
  end

  def take_place
    super(1)
  end
end
