module DataList
  def select_train
    @store[:trains].each_with_index do |train, index|
      puts "#{index + 1}. Номер поезда: #{train.number}"
    end
  end

  def select_train_car
    @store[:train_cars].each_with_index do |train_car, index|
      puts "#{index + 1}. Тип вагона: #{train_car.type}"
    end
  end

  def select_route
    @store[:routes].each_with_index do |route, index|
      puts "#{index + 1}. Маршрут: #{route.stations.first.name} - #{route.stations.last.name}"
    end
  end

  def show_stations
    @store[:stations].each_with_index do |station, index|
      p "#{index}. = #{station.name}"
    end
  end
end
