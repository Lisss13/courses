require_relative '../modules/manufacturer'

# Train car for Train
class TrainCar
  attr_reader :type, :capacity
  include CompanyManufacturer

  TRAIN_CAR_ERROR = "Вагон не может быть нулевым"

  ##
  # @param [String] type type of train car
  # @param [Number] capacity number of free seats for passengers or places for goods
  def initialize(type, capacity)
    @type = type
    @capacity = capacity
    @free_place = capacity
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def take_place(place)
    @free_place -= place if @free_place > place
  end

  def busy_place
    @capacity - @free_place
  end

  def free_place
    @free_place
  end

  protected

  def validate!
    raise TRAIN_CAR_ERROR if type.nil?
    true
  end
end
