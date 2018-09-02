# Base class for Trains
class Train
  attr_reader :route, :type, :current_station, :speed, :train_cars, :id

  ##
  # @param [Number] id number or id of train
  # @param [String] type type of train
  def initialize(id, type)
    @id = id
    @type = type
    @speed = 0
    @train_cars = []
  end

  ##
  # Increase train speed
  def gain_speed
    @speed += 10
  end

  ##
  # Reduce train speed
  def reduce_speed
    @speed -= 10
    @speed = 0 if @speed < 0
  end

  ##
  # Stop train
  def stop
    @speed = 0
  end

  ##
  # Add train car to train
  # @param [TrainCar] train_car object of TrainCar
  def add_train_car(train_car)
    @train_cars.push(train_car) if @speed == 0
  end

  ##
  # Remove train car
  # @param [TrainCar] train_car object of TrainCar
  def remove_train_car(train_car)
    @train_cars.delete(train_car) if @speed == 0 && @train_cars.length >= 0
  end

  ##
  # Add train route
  # @param [Route] route train route
  def itinerary(route)
    @route = route
    @current_station = route.stations.first
    @current_station.accept_train self
  end

  ##
  # Go to the next station
  def go_to_next_station
    @current_station.send_train self
    @current_station = next_station
    @current_station.accept_train self
  end

  ##
  # Go to the previous station
  def go_to_previous_station
    @current_station.send_train self
    @current_station = previous_station
    @current_station.accept_train self
  end

  # auxiliary methods for go_to_next_station and go_to_previous_station
  private
    ##
    # Get next station
    def next_station
      station_index = @route.stations.index(@current_station)
      stations = @route.stations
      unless station_index == stations.size
        stations[station_index + 1]
      end
    end

    ##
    # Get previous station
    def previous_station
      station_index = @route.stations.index(@current_station)
      unless station_index == 0
        @current_station[station_index - 1]
      end
    end
end
