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
