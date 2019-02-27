require_relative '../modules/manufacturer'

# Train car for Train
class TrainCar
  attr_reader :type
  include CompanyManufacturer

  TRAIN_CAR_ERROR = "Вагон не может быть нулевым"

  ##
  # @param [String] type type of train car
  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise TRAIN_CAR_ERROR if type.nil?
    true
  end
end
