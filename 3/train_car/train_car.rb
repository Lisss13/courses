require_relative '../modules/manufacturer'

# Train car for Train
class TrainCar
  attr_reader :type
  include CompanyManufacturer
  ##
  # @param [String] type type of train car
  def initialize(type)
    @type = type
  end
end
