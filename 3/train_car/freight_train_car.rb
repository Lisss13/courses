require_relative 'train_car'

class FreightTrainCar < TrainCar
  def initialize(capacity)
    super('грузовой', capacity)
  end
end
