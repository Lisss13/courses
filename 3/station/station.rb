require_relative '../modules/instance_counter'

class Station
  attr_reader :name, :trains
  include InstanceCounter

  @@all_station = []

  def self.all
    @@all_station
  end
  ##
  # @param [String] name name of station
  def initialize(name)
    @name = name
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
end
