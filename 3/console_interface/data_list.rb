module DataList
  def select_train
    @store[:trains].each_with_index do |train, index|
      puts "#{index + 1}. Номер поезда: #{train.id}"
    end
  end

  def select_train_car
    @store[:train_cars].each_with_index do |train_car, index|
      puts "#{index + 1}. Тип вагона: #{train_car.type}"
    end
  end

  def select_route
    @store[:routes].each_with_index do |route, index|
      puts "#{index + 1}. Маршрут: #{route.stations.first} - #{route.stations.last}"
    end
  end

  def show_stations
    puts 'Список станций:'
    @store[:stations].each { |station| p station.name }
    menu
  end
end
