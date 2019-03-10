require_relative '../modules/manufacturer'

# Train car for Train
class TrainCar
  attr_reader :type, :number
  include CompanyManufacturer

  TRAIN_CAR_ERROR = "Вагон не может быть нулевым"

  ##
  # @param [String] type type of train car
  # @param [Number] number number of free seats for passengers or places for goods
  def initialize(type, number)
    @type = type
    @number = number
    @free_place = number
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def take_place(place = 1)
    if @type == 'пассажирский'
      @free_place -= 1 if @free_place > 0
    else
      @free_place = @free_place - place if @free_place > place
    end
  end

  def busy_place
    @number - @free_place
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
