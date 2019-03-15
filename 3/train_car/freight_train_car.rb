require_relative 'train_car'

# class for freight train car
class FreightTrainCar < TrainCar
  ##
  # @param [Number] capacity amount of cargo
  def initialize(capacity)
    super('грузовой', capacity)
  end
end
