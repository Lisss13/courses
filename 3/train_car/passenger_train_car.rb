require_relative 'train_car'

# class for passenger train car
class PassengerTrainCar < TrainCar
  ##
  # @param [Number] capacity number of passenger seats
  def initialize(capacity)
    super('пассажирский', capacity)
  end

  ##
  # take a seat in the train car
  def take_place
    super(1)
  end
end
