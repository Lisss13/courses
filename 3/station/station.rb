require_relative '../modules/instance_counter'

class Station
  attr_reader :name, :trains
  include InstanceCounter

  NAME_EMPTY = "Название станции не может быть пустой"
  NAME_LENGTH = "Название станции должно содержать не менее 3 букв"

  @@all_station = []

  def self.all
    @@all_station
  end
  ##
  # @param [String] name name of station
  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
    @@all_station.push(self)
  end

  ##
  # Arrival train
  # @param [Train] train
  def accept_train(train)
    @trains << train
  end

  ##
  # Getting a list of trains to depend on the type
  # @param [String] type type of Train
  # @return [Array<Train>]
  def trains_with_type(type)
    @trains.select { |train| train.type == type }
  end

  ##
  # Sending a train from the station
  # @param [Train] current_train
  # @return [Array<Train>]
  def send_train(current_train)
    @trains.delete(current_train)
  end

  ##
  # Validation of parameters
  def valid?
    validate!
  rescue
    false
  end

  protected
    def validate!
      raise NAME_EMPTY if name.nil?
      raise NAME_LENGTH if name.length < 3
      true
    end
end
