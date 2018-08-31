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
