class Route
  attr_reader :stations
  ##
  # @param [Station] starting_point start station
  # @param [Station] final_point finish station
  def initialize(starting_point, final_point)
    @stations = [starting_point, final_point]
  end

  ##
  # Add station to route
  # @param [Station] station
  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  ##
  # Remove station in route
  # @param [Station] station_to_remove
  def remove_station(station_to_remove)
    if station_to_remove != @stations.first && station_to_remove != @stations.last
      @stations.delete(station_to_remove)
    end
  end

  ##
  # Print all station
  def print_station
    @stations.each { |station| p station }
  end
end
