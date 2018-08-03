class Station
  attr_reader :name, :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_with_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(current_train)
    @trains.delete(current_train)
  end
end

class Route
  attr_reader :stations
  def initialize(starting_point, final_point)
    @stations = [starting_point, final_point]
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station_to_remove)
    if station_to_remove != @stations.first && station_to_remove != @stations.last
      @stations.delete(station_to_remove)
    end
  end

  def print_station
    @stations.each { |station| p station }
  end
end

class Train
  attr_reader :number_wagons, :route, :type, :current_station, :speed

  def initialize(id, type, number_wagons)
    @id = id
    @type = type
    @number_wagons = number_wagons
    @speed = 0
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

  def add_number_wagons
    @number_wagons += 1 if @speed == 0
  end

  def remove_number_wagons
    @number_wagons -= 1 if @speed == 0 && @number_wagons >= 0
  end

  # маршрут следование
  def itinerary(route)
    @route = route
    @current_station = route.stations.first
    @current_station.accept_train self
  end

  def go_to_next_station
    @current_station.send_train self
    @current_station = self.next_station
    @current_station.accept_train self
  end

  def go_to_previous_station
    @current_station.send_train self
    @current_station = self.previous_station
    @current_station.accept_train self
  end

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
