require_relative '../modules/manufacturer'

# Train car for Train
class TrainCar
  attr_reader :type
  include CompanyManufacturer
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
      raise "Вагон не может быть нулевым" if type.nil?
      true
    end
end
