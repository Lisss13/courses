require_relative '../modules/instance_counter'

class Route
  attr_reader :stations
  include InstanceCounter
  INVALID_STATION = "Маршрут должен состоять из объектов станции"

  ##
  # @param [Station] starting_point start station
  # @param [Station] final_point finish station
  def initialize(starting_point, final_point)
    @stations = [starting_point, final_point]
    register_instance
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

  def remove_station_by_name(station_name)
    if station_name != @stations.first.name && station_name != @stations.last.name
      @stations.delete_if { |stations| stations.name == station_name }
    end
  end

  ##
  # Print all station
  def print_station
    @stations.each { |station| p station.name }
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise INVALID_STATION unless stations.first.is_a?(Station) && stations.last.is_a?(Station)
  end
end
