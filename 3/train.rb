class Train
  attr_reader :route, :type, :current_station, :speed, :train_cars

  def initialize(id, type)
    @id = id
    @type = type
    @speed = 0
    @train_cars = []
  end

  def gain_speed
    @speed += 10
  end

  def reduce_speed
    @speed -= 10
    @speed = 0 if @speed < 0
  end

  def stop
    @speed = 0
  end

  def add_train_car(train_car)
    @train_cars.push(train_car) if @speed == 0
  end

  def remove_train_car(train_car)
    @train_cars.delete(train_car) if @speed == 0 && @train_cars.length >= 0
  end

  # маршрут следование
  def itinerary(route)
    @route = route
    @current_station = route.stations.first
    @current_station.accept_train self
  end

  def go_to_next_station
    @current_station.send_train self
    @current_station = next_station
    @current_station.accept_train self
  end

  def go_to_previous_station
    @current_station.send_train self
    @current_station = previous_station
    @current_station.accept_train self
  end

  # вспомогательные метот дял метода go_to_next_station
  private
    def next_station
      station_index = @route.stations.index(@current_station)
      stations = @route.stations
      unless station_index == stations.size
        stations[station_index + 1]
      end
    end

    def previous_station
      station_index = @route.stations.index(@current_station)
      unless station_index == 0
        @current_station[station_index - 1]
      end
    end
end
