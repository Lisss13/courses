require_relative '../modules/manufacturer'
require_relative '../modules/acessors'
require_relative '../modules/validation'

# Train car for Train
class TrainCar
  attr_reader :type, :capacity, :free_place
  include CompanyManufacturer
  include Accessors
  include Validation

  ##
  # @param [String] type type of train car
  # @param [Number] capacity number of free seats for passengers or places
  # for goods
  def initialize(type, capacity)
    @type = type
    @capacity = capacity
    @free_place = capacity
    validate!
  end

  ##
  # take a seat in the train car
  # @param [Number] place amount of space
  def take_place(place)
    @free_place -= place if @free_place > place
  end

  ##
  # giv occupied space in the train car
  def busy_place
    @capacity - @free_place
  end
end
